{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    metals
    coursier
    maven
    (lib.hiPrio scala_2_13)
    scalafmt
  ];
}
