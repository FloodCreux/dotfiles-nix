{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rerere.enabled = true;
      diff.algorithm = "histogram";
      merge.conflictstyle = "zdiff3";
    };
    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv"
    ];
  };

  programs.delta = {
    enable = true; # Better diff viewer
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
    };
  };
}
