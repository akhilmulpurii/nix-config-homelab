{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "cinnamon") {

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
  };

  services.libinput.enable = true;
  services.displayManager.defaultSession = "cinnamon";

  environment.systemPackages = [ pkgs.arc-theme ];
  environment.cinnamon.excludePackages = (
    with pkgs;
    [
      celluloid
      nemo
      xviewer
      pix
      xterm
      gnome-terminal
    ]
  );
}
