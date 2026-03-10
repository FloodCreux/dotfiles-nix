{
  config,
  lib,
  ...
}:

let
  enableNetskope = config.modules.netskope.enable;
in
{
  options.modules.netskope.enable = lib.mkEnableOption "Netskope SSL inspection certificate handling";

  config = lib.mkMerge [
    {
      environment = {
        systemPath = [ "/opt/homebrew/bin" ];
        pathsToLink = [ "/Applications" ];

        variables = {
          EDITOR = "nvim";
          PAGER = "less";

          LANG = "en_US.UTF-8";
          LC_ALL = "en_US.UTF-8";

          XDG_CONFIG_HOME = "$HOME/.config";
          XDG_DATA_HOME = "$HOME/.local/share";
          XDG_STATE_HOME = "$HOME/.local/state";
          XDG_CACHE_HOME = "$HOME/.cache";
        };
      };
    }

    (lib.mkIf enableNetskope {
      environment.variables = {
        NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates-combined.crt";
        SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates-combined.crt";
        REQUESTS_CA_BUNDLE = "/etc/ssl/certs/ca-certificates-combined.crt";
        CURL_CA_BUNDLE = "/etc/ssl/certs/ca-certificates-combined.crt";
        NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates-combined.crt";
      };

      nix.settings = {
        ssl-cert-file = "/etc/ssl/certs/ca-certificates-combined.crt";
      };

      # Combine system CA certificates with Netskope CA cert for SSL inspection compatibility.
      # The Netskope agent intercepts HTTPS traffic and re-signs it with its own CA, which
      # Nix doesn't trust by default. This creates a combined bundle on every activation.
      system.activationScripts.postActivation.text = ''
        NETSKOPE_CERT="/Library/Application Support/Netskope/STAgent/data/nscacert.pem"
        COMBINED="/etc/ssl/certs/ca-certificates-combined.crt"
        mkdir -p "$(dirname "$COMBINED")"
        if [ -f "$NETSKOPE_CERT" ]; then
          cat /etc/ssl/certs/ca-certificates.crt "$NETSKOPE_CERT" > "$COMBINED"
          chmod 644 "$COMBINED"
          echo "Combined CA bundle created with Netskope cert at $COMBINED"
        else
          cp /etc/ssl/certs/ca-certificates.crt "$COMBINED"
          chmod 644 "$COMBINED"
          echo "Combined CA bundle created (no Netskope cert found) at $COMBINED"
        fi
      '';
    })
  ];
}
