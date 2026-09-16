{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "budgie") {

  services.xserver.enable = true;
  services.desktopManager.budgie.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  services.displayManager.defaultSession = "budgie-desktop";

  # Optional:
  environment.budgie.excludePackages = with pkgs; [
    mate-terminal
    bluejay
    nemo
    mate-calc
    pluma
    xterm
    gnome-terminal
  ];
}
