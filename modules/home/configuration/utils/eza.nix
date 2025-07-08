{ ... }:
{
  programs.eza = {
    enable = true;
    extraOptions = [
      "--group-directories-first"
      "--no-user"
      "--no-time"
    ];
  };
}
