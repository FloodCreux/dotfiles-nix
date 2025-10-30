{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (pkgs.buildEnv {
      name = "java-combined";
      paths = with pkgs; [
        jdk21
        jdk8
        jdk11
        jdk17
      ];
      pathsToLink = [
        "/bin"
        "/lib"
      ];
      ignoreCollisions = true;
    })
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21}";
  };
}
