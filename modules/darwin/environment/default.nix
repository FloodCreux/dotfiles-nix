{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    carapace
    curl
    fd
    gh
    jq
    lazygit
    less
    neovim
    nixd
    nushell
    ripgrep
    skhd
    templ
    yazi
    zigpkgs.master
    zoxide
  ];

  environment.shellAliases = {
    tf = "terraform";
    code = "open -a 'Visual Studio Code'";
    ls = "ls --color";
    vim = "nvim";
    vimdiff = "nvim -d";
    c = "clear";
    grep = "grep --color";
    nixswitch = "darwin-rebuild switch --flake ~/personal/nix/.#default";
    nixup = "pushd ~/personal/nix; nix flake update; nixswitch; popd";
    wixswitch = "darwin-rebuild switch --flake ~/personal/nix/.#work";
    wixup = "pushd ~/personal/nix; nix flake update; wixswitch; popd";
    flushdns = "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
    tmux-sessionizer = "sh ~/.local/scripts/tmux-sessionizer";
  };

  environment.shells = [ pkgs.nushell ];

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    NIX_HOME = "/etc/profiles/per-user/${username}/";
  };
}
