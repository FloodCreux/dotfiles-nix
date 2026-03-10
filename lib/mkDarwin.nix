{
  inputs,
  pkgs,
  username,
  machineConfig ? null,
  system ? "aarch64-darwin",
}:

let
  darwin = inputs.darwin;
  home-manager = inputs.home-manager;
  catppuccin = inputs.catppuccin;
in
darwin.lib.darwinSystem {
  inherit system;

  pkgs = pkgs;

  # Pass username to all darwin modules via specialArgs
  specialArgs = {
    inherit username;
  };

  modules = [
    ../modules/darwin

    home-manager.darwinModules.home-manager
    {
      home-manager = {
        backupFileExtension = "backup";
        users.${username} = {
          imports = [
            catppuccin.homeModules.catppuccin
            ../modules/home-manager
          ];
        };
      };
    }
  ]
  ++ (if machineConfig != null then [ machineConfig ] else [ ]);
}
