{
  plugins.lualine = {
    enable = true;
    iconsEnabled = true;
    theme = "catppuccin";

    sections = {
      lualine_a = [ "mode" ];
      lualine_b = [ "branch" "diff" ];
      lualine_c = [ "filename" ];
      lualine_x = [ "encoding" "fileformat" "filetype" ];
    };
  };
}
