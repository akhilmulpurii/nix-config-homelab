{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "cinnamon") {

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
    displayManager.defaultSession = "cinnamon";
  };

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
