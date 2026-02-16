#!/bin/bash

# This script creates a combined CA certificate bundle that includes the Netskope
# SSL inspection CA cert alongside the system CA certificates. This is required
# because Netskope intercepts HTTPS traffic and re-signs it with its own CA,
# which tools like Nix, Python (requests), and Node.js don't trust by default.
#
# Run this script with sudo to bootstrap the Nix fix, then run darwin-rebuild.
# After that, the nix-darwin activation script handles future updates automatically.

set -euo pipefail

# Resolve the real user even when run via sudo.
# SUDO_USER is set by sudo to the invoking user's name.
if [ -n "${SUDO_USER:-}" ] && [ "$SUDO_USER" != "root" ]; then
	USERNAME="$SUDO_USER"
elif [ "$(whoami)" = "root" ]; then
	# Fallback: find the console user via macOS system call
	USERNAME=$(/usr/bin/stat -f "%Su" /dev/console 2>/dev/null || echo "")
	if [ -z "$USERNAME" ] || [ "$USERNAME" = "root" ]; then
		echo "ERROR: Could not determine the real user. Please run as: sudo -u \$USER bash $0"
		exit 1
	fi
else
	USERNAME=$(whoami)
fi
echo "User is: $USERNAME"

NETSKOPE_CERT="/Library/Application Support/Netskope/STAgent/data/nscacert.pem"
SYSTEM_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
COMBINED_NIX="/etc/ssl/certs/ca-certificates-combined.crt"
COMBINED_USER="/Users/$USERNAME/nscacert_combined.pem"

# --- Ensure we have root for writing to /etc/ssl/certs/ ---
if [ "$(id -u)" -ne 0 ]; then
	echo "This script needs root to write to /etc/ssl/certs/ and restart nix-daemon."
	echo "Re-running with sudo..."
	exec sudo bash "$0" "$@"
fi

# --- Create combined CA bundle for Nix ---
echo ""
echo "=== Nix CA Bundle ==="

if [ ! -f "$NETSKOPE_CERT" ]; then
	echo "WARNING: Netskope CA cert not found at $NETSKOPE_CERT"
	echo "Netskope may not be installed. Skipping combined bundle creation."
else
	if [ -f "$SYSTEM_CA_BUNDLE" ]; then
		# Create combined bundle in /etc/ssl/certs/ for Nix daemon
		cat "$SYSTEM_CA_BUNDLE" "$NETSKOPE_CERT" > "$COMBINED_NIX"
		echo "Combined Nix CA bundle created at $COMBINED_NIX"
	else
		echo "WARNING: System CA bundle not found at $SYSTEM_CA_BUNDLE"
		echo "Falling back to keychain export..."
		security find-certificate -a -p \
			/System/Library/Keychains/SystemRootCertificates.keychain \
			/Library/Keychains/System.keychain > "$COMBINED_NIX"
		cat "$NETSKOPE_CERT" >> "$COMBINED_NIX"
		echo "Combined Nix CA bundle created (from keychain) at $COMBINED_NIX"
	fi

	# Inject ssl-cert-file into nix.conf so the nix-daemon uses the combined bundle.
	# The nix.conf is a symlink managed by nix-darwin, but we need to temporarily
	# patch it for bootstrap (before darwin-rebuild can run). After darwin-rebuild,
	# the generated nix.conf will include this setting permanently.
	NIX_CONF="/etc/nix/nix.conf"
	NIX_CONF_REAL=$(readlink -f "$NIX_CONF" 2>/dev/null || echo "$NIX_CONF")

	if [ -f "$NIX_CONF_REAL" ]; then
		if grep -q "^ssl-cert-file" "$NIX_CONF_REAL" 2>/dev/null; then
			echo "ssl-cert-file already set in $NIX_CONF_REAL"
		else
			# nix.conf is in the nix store (read-only), so write to a mutable location
			MUTABLE_NIX_CONF="/etc/nix/nix.custom.conf"
			cp "$NIX_CONF_REAL" "$MUTABLE_NIX_CONF"
			echo "ssl-cert-file = $COMBINED_NIX" >> "$MUTABLE_NIX_CONF"
			# Point the symlink at our mutable copy
			ln -sf "$MUTABLE_NIX_CONF" "$NIX_CONF"
			echo "Patched nix.conf with ssl-cert-file = $COMBINED_NIX"
			echo "(darwin-rebuild will overwrite this with the permanent config)"
		fi
	else
		echo "WARNING: nix.conf not found at $NIX_CONF_REAL"
	fi

	# Restart nix-daemon so it re-reads nix.conf with the ssl-cert-file setting.
	# Note: launchctl setenv is blocked by SIP on modern macOS, so we patch nix.conf directly.
	if launchctl print system/org.nixos.nix-daemon &>/dev/null; then
		launchctl kickstart -k system/org.nixos.nix-daemon
		echo "nix-daemon restarted"
	else
		echo "nix-daemon service not found, skipping restart."
		echo "You may need to restart the nix-daemon manually."
	fi
fi

# --- Create combined CA bundle for user tools (Python requests, Node.js, etc.) ---
echo ""
echo "=== User CA Bundle ==="

if [ ! -f "$NETSKOPE_CERT" ]; then
	echo "Skipping user bundle (no Netskope cert)."
else
	if [ -f "$COMBINED_USER" ]; then
		echo "User combined cert already exists at $COMBINED_USER, regenerating."
	fi
	security find-certificate -a -p \
		/System/Library/Keychains/SystemRootCertificates.keychain \
		/Library/Keychains/System.keychain > "$COMBINED_USER"
	echo "User combined cert created at $COMBINED_USER"
fi

# --- Set environment variables in shell RC file ---
echo ""
echo "=== Shell Environment ==="

if [ -f "/Users/$USERNAME/.zshrc" ]; then
	echo "Zshrc exists."
	RCFILE="/Users/$USERNAME/.zshrc"
elif [ -f "/Users/$USERNAME/.bashrc" ]; then
	echo "Bashrc exists."
	RCFILE="/Users/$USERNAME/.bashrc"
else
	echo "Neither .bashrc nor .zshrc exists."
	exit 1
fi

# Resolve symlinks so sed -i works (it can't edit symlinks in-place)
RCFILE=$(readlink -f "$RCFILE" 2>/dev/null || /usr/bin/perl -MCwd -e 'print Cwd::realpath($ARGV[0])' "$RCFILE")
echo "RC file is: $RCFILE"

# Helper to ensure an export line is in the RC file
ensure_export() {
	local var_name="$1"
	local var_value="$2"
	if grep -q "export ${var_name}=" "$RCFILE"; then
		echo "$var_name is already set (updating value)."
		sed -i '' "s|^export ${var_name}=.*|export ${var_name}='${var_value}'|" "$RCFILE"
	else
		echo "$var_name not set, adding."
		echo "export ${var_name}='${var_value}'" >> "$RCFILE"
	fi
}

ensure_export "REQUESTS_CA_BUNDLE" "$COMBINED_USER"
ensure_export "NODE_EXTRA_CA_CERTS" "$COMBINED_USER"
ensure_export "NIX_SSL_CERT_FILE" "$COMBINED_NIX"

echo ""
echo "=== Done ==="
echo "Run the following to apply in your current shell:"
echo "  source $RCFILE"
echo ""
echo "Then rebuild nix-darwin to make the Nix fix permanent:"
echo "  darwin-rebuild switch --flake ~/personal/nix#work"
