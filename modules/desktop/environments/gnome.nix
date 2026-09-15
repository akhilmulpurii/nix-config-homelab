{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "gnome") {

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-photos
      gnome-maps
      gnome-contacts
      gnome-connections
      gnome-initial-setup
      atomix
      hitori
      iagno
      tali
      epiphany
      geary
      totem
      gedit
      gnome-music
      simple-scan
      gnome-console
    ]
  );

}
