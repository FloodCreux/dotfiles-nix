{ pkgs, ... }:

pkgs.metals.override {
  extraJavaOpts = "-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms100m -Dmetals.client=nvim-lsp";
}
