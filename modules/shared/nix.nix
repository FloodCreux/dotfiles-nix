{
  enableNetskope ? false,
}:
{
  settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  }
  // (
    if enableNetskope then
      {
        ssl-cert-file = "/etc/ssl/certs/ca-certificates-combined.crt";
      }
    else
      { }
  );
}
