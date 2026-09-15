{ config, lib, ... }:

lib.mkIf (config.desktop.environment == "gnome") {

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

}
