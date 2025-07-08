{ ... }:
{
  home.stateVersion = "24.11";
  imports = [
    ../modules/home/configuration
  ];
  programs.git = {
    userName = "Stanislav Stoyanov";
    userEmail = "grimerssy@gmail.com";
  };
}
