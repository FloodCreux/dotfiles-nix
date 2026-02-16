{
  pkgs,
  username,
  extraSystemPackages ? [ ],
  enableNetskope ? false,
  ...
}:

let
  nix = import ../shared/nix.nix { inherit enableNetskope; };

  # Helper to import modules with pkgs or username
  importWith = path: args: import path args;
  importPkgs = path: importWith path { inherit pkgs; };
  importUsername = path: importWith path { inherit username; };
  importAll =
    path:
    importWith path {
      inherit pkgs;
      inherit username;
    };

in
{
  nix = nix;

  # Merge machine-specific packages with core configuration
  environment.systemPackages = extraSystemPackages;

  imports = [
    ./nixpkgs
    (importWith ./environment { inherit pkgs enableNetskope; })
    (importUsername ./system)
    (importAll ./users)
    (importPkgs ./carapace)
    (importPkgs ./curl)
    (importPkgs ./fd)
    (importPkgs ./gh)
    (importPkgs ./go)
    ./homebrew
    (importPkgs ./jq)
    (importPkgs ./lazygit)
    (importPkgs ./less)
    (importPkgs ./nvim)
    (importPkgs ./nixd)
    (importPkgs ./nushell)
    (importPkgs ./ohmyposh)
    (importPkgs ./python)
    (importPkgs ./ripgrep)
    (importPkgs ./rust)
    (importPkgs ./scala)
    (importPkgs ./tree)
    (importPkgs ./yazi)
    (importPkgs ./zig)
    ./zsh
  ];
}
