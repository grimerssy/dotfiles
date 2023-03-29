{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      palette = "catppuccin_frappe";
      add_newline = false;
      format = "$nix_shell$directory$git_branch$package$rust$nodejs$golang$character";
      character = {
        success_symbol = "\n[](green)";
        error_symbol = "\n[](red)";
      };
      nix_shell = {
        format = "[$state]($style) ";
        symbol = "";
        style = "bold #7eb6e1";
      };
      directory = {
        style = "bold directory";
        truncation_length = 5;
      };
      git_branch = {
        symbol = "";
        style = "bold branch";
      };
      package = {
        symbol = "";
        style = "bold package";
      };
      rust = {
        symbol = "rust ";
        style = "bold #f74b00";
      };
      nodejs = {
        symbol = "node ";
        style = "bold #82cd28";
      };
      golang = {
        symbol = "go ";
        style = "bold #68d1de";
      };
      palettes.catppuccin_frappe = {
        rosewater = "#f2d5cf";
        flamingo = "#eebebe";
        pink = "#f4b8e4";
        mauve = "#ca9ee6";
        red = "#e78284";
        maroon = "#ea999c";
        peach = "#ef9f76";
        yellow = "#e5c890";
        green = "#a6d189";
        teal = "#81c8be";
        sky = "#99d1db";
        sapphire = "#85c1dc";
        blue = "#8caaee";
        lavender = "#babbf1";
        text = "#c6d0f5";
        subtext1 = "#b5bfe2";
        subtext0 = "#a5adce";
        overlay2 = "#949cbb";
        overlay1 = "#838ba7";
        overlay0 = "#737994";
        surface2 = "#626880";
        surface1 = "#51576d";
        surface0 = "#414559";
        base = "#303446";
        mantle = "#292c3c";
        crust = "#232634";
        directory = "#babbf1";
        branch = "#ca9ee6";
        package = "#eed49f";
      };
    };
  };
}
