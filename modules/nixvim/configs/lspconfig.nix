{
  plugins.lsp = {
    enable = true;
    servers = {
      lua-ls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      nil_ls.enable = true;
      metals = { enable = true; };
    };
  };
}
