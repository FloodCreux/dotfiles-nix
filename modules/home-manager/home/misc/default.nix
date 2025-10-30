{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # gimp
    hadoop
    chafa
    utf8proc
    lz4
    arrow-cpp
  ];
}
