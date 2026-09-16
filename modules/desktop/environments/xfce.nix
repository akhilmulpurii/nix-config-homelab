{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "xfce") {

  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    displayManager.defaultSession = "xfce";
  };

}
