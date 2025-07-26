{ ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    signing = {
      key = null;
      signByDefault = true;
    };
    extraConfig = {
      core.editor = "nvim";
      pull = {
        ff = "only";
      };
      init.defaultBranch = "main";
      format.pretty = "oneline";
    };
  };
}
