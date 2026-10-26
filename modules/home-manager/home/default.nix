{ ... }:
{
  home.stateVersion = "25.11";

  home.enableNixpkgsReleaseCheck = false;

  imports = [
    # Toggleable language/tool modules
    ./lua
    ./rust
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICOLOR = 1;
    EDITOR = "nvim";
  };

  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "macchiato";
    accent = "mauve";

    bat = {
      enable = true;
    };
  };

  # Enable all toggleable modules by default.
  # Machine configs can override these with `modules.<name>.enable = false;`
  modules = {
    lua.enable = false;
    rust.enable = true;
  };
}
