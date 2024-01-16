{
  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      lua = [ "stylua" ];
      python = [ "isort" "black" ];
      javascript = [[ "prettierd" "prettier" ]];
      scala = [ "scalafmt" ];
      terraform = [ "terraform_fmt" ];
      rust = [ "rustfmt" ];
      cs = [ "csharpier" ];
      nix = [ "nixfmt" ];
      yaml = [ "yamlfix" ];
    };
  };
}
