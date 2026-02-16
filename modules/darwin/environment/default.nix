{
  pkgs,
  enableNetskope ? false,
  ...
}:
{
  environment = {
    shells = with pkgs; [
      nushell
    ];

    systemPackages = [
      pkgs.coreutils
    ];

    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];

    variables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      SHELL = "${pkgs.zsh}/bin/zsh";
    }
    // (
      if enableNetskope then
        {
          NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates-combined.crt";
        }
      else
        { }
    );
  };
}
// (
  if enableNetskope then
    {
      # Combine system CA certificates with Netskope CA cert for SSL inspection compatibility.
      # The Netskope agent intercepts HTTPS traffic and re-signs it with its own CA, which
      # Nix doesn't trust by default. This creates a combined bundle on every activation.
      system.activationScripts.postActivation.text = ''
        NETSKOPE_CERT="/Library/Application Support/Netskope/STAgent/data/nscacert.pem"
        COMBINED="/etc/ssl/certs/ca-certificates-combined.crt"
        if [ -f "$NETSKOPE_CERT" ]; then
          cat /etc/ssl/certs/ca-certificates.crt "$NETSKOPE_CERT" > "$COMBINED"
          echo "Combined CA bundle created with Netskope cert at $COMBINED"
        else
          cp /etc/ssl/certs/ca-certificates.crt "$COMBINED"
          echo "Combined CA bundle created (no Netskope cert found) at $COMBINED"
        fi
      '';
    }
  else
    { }
)
