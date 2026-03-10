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

in
{
  nix = nix;

  # Merge machine-specific packages with core configuration
  environment.systemPackages = extraSystemPackages;

  imports = [
    ./nixpkgs
    (importWith ./environment { inherit pkgs enableNetskope; })
    (importUsername ./system)
    (importUsername ./users)
    (importPkgs ./curl)
    (importPkgs ./fd)
    (importPkgs ./gh)
    (importPkgs ./go)
    ./homebrew
    (importPkgs ./jq)
    (importPkgs ./less)
    (importPkgs ./nvim)
    (importPkgs ./nixd)
    (importPkgs ./python)
    (importPkgs ./ripgrep)
    (importPkgs ./rust)
    (importPkgs ./scala)
    (importPkgs ./tree)
    (importPkgs ./yazi)
  ];
}
