{ pkgs, ... }:
{
  home.packages = with pkgs; [
    terraform
    terraform-ls
    kubernetes-helm
    helm-ls
  ];
}
