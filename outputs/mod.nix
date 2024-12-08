{
  inputs,
  system,
  pkgs,
  extraSpecialArgs,
  username,
  ...
}:
{
  home-manager = {
    inherit extraSpecialArgs;

    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      inputs.neovim-flake.homeManagerModules.${system}.default
    ];

    users.${username} = import ../modules/home-manager { inherit pkgs username; };
  };
}
