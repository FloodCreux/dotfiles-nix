{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ curl ];
}
