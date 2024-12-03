{ inputs }:
{ system, username }:
{ pkgs, ... }:
{
  imports = [
    ./home
    ./bat
  ];

  #--------------------------------------------------------
  # programs
  #--------------------------------------------------------

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza.enable = true;
  programs.git.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk8;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };

    initExtra = builtins.readFile ./dotfiles/zsh/.zshrc;
  };

  programs.oh-my-posh = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.replaceStrings [ "$NIX_HOME" ] [ "/etc/profiles/per-user/${username}" ] (
      builtins.readFile ./dotfiles/wezterm/wezterm.lua
    );
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/tmux/tmux.conf;
    shell = "${pkgs.nushell}/bin/nu";
    # shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
  };

  programs.zellij = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "~/.password-store";
    };
  };
}
