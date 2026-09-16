{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "lxqt") {

  services.xserver.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;

  # Add the Wayland session package to the system environment
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-wayland-session
  ];

  # Optional:
  environment.lxqt.excludePackages = with pkgs; [

  ];
}
