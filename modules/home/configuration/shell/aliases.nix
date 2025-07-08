{ pkgs, ... }:
{
  programs.bash.enable = true;
  programs.zsh.enable = pkgs.stdenv.hostPlatform.isDarwin;
  home.shellAliases =
    let
      nvim = "nvim";
      tmux = "${pkgs.tmux}/bin/tmux";
    in
    {
      v = nvim;
      s = "tmux-session";
      a = "${tmux} attach";
    };
}
