{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$nix_shell$directory$git_branch$package$character";
      character = {
        format = "\n$symbol ";
        success_symbol = "[](green)";
        error_symbol = "[](red)";
      };
      nix_shell = {
        format = "[$state]($style) ";
        symbol = "";
        style = "bold #7eb6e1";
        heuristic = true;
        unknown_msg = "impure";
      };
      git_branch.symbol = "";
      package.symbol = "";
    };
  };
}
