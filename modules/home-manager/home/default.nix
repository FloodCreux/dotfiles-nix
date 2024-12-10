{ pkgs, username, ... }:
let
  catppuccin-lazygit = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "lazygit";
    rev = "30bff2e6d14ca12a09d71e5ce4e6a086b3e48aa6";
    sha256 = "sha256-mmNA7MpORvdCb37myo2QqagPK46rxRxD0dvUMsHegEM=";
  };
in
{
  # Don't change this unless you know what you're doing
  home.stateVersion = "24.05";

  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./clang
    ./containers
    ./csharp
    ./git
    ./haskell
    ./java
    ./misc
    ./nix
    ./node
    ./notes
    ./scala
    ./sql
    ./zig
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  home.file.".inputrc".source = ./dotfiles/inputrc;

  home.file.".config/alacritty/alacritty.yml".source = ./dotfiles/alacritty/alacritty.yml;
  home.file.".config/alacritty/catppuccin-macchiato.yml".source =
    ./dotfiles/alacritty/catppuccin-macchiato.yml;

  home.file.".zsh/starship.zsh".source = ./dotfiles/zsh/starship.zsh;
  home.file.".zsh/aliases.zsh".source = ./dotfiles/zsh/aliases.zsh;
  home.file.".zsh/integrations.zsh".source = ./dotfiles/zsh/integrations.zsh;

  home.file.".config/ohmyposh/zen.toml".source = ./dotfiles/ohmyposh/zen.toml;

  home.file.".local/scripts/tmux-sessionizer" = {
    source = ./scripts/tmux/tmux-sessionizer.sh;
    executable = true;
  };

  home.file.".local/scripts/tmux-cht.sh" = {
    source = ./scripts/tmux/tmux-cht.sh;
    executable = true;
  };

  home.file.".tmux-cht-languages" = {
    source = ./dotfiles/tmux/.tmux-cht-languages;
    executable = true;
  };

  home.file.".tmux-cht-command" = {
    source = ./dotfiles/tmux/.tmux-cht-command;
    executable = true;
  };

  home.file.".config/aerospace/aerospace.toml" = {
    source = ./dotfiles/aerospace/aerospace.toml;
    executable = true;
  };

  home.file.".config/nushell/config.nu" = {
    source = ./dotfiles/nushell/config.nu;
    executable = true;
  };

  home.file.".config/nushell/env.nu" = {
    source = ./dotfiles/nushell/env.nu;
    executable = true;
  };

  home.file.".config/tmux/tmux.reset.conf" = {
    source = ./dotfiles/tmux/tmux.reset.conf;
    executable = true;
  };

  home.file.".config/starship/starship.toml".source = ./dotfiles/starship/starship.toml;

  home.file.".config/skhd/skhdrc" = {
    source = ./dotfiles/skhd/skhdrc;
    executable = true;
  };

  home.file.".config/yabai/yabairc" = {
    source = ./dotfiles/yabai/yabairc;
    executable = true;
  };

  home.file.".config/zellij/config.kdl" = {
    source = ./dotfiles/zellij/config.kdl;
    executable = true;
  };

  home.file.".gitkraken/themes/catppuccin-macchiato-theme.jsonc" = {
    source = ./dotfiles/gitkraken/themes/catppuccin-macchiato-theme.jsonc;
    executable = true;
  };

  home.file.".gitkraken/themes/catppuccin-mocha-theme.jsonc" = {
    source = ./dotfiles/gitkraken/themes/catppuccin-mocha-theme.jsonc;
    executable = true;
  };

  home.file.".local/bin/zet" = {
    source = ./scripts/second-brain/zet;
    executable = true;
  };

  home.file."personal/themes/lazygit" = {
    source = catppuccin-lazygit;
    executable = true;
  };
}
