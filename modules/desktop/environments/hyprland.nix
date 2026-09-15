{ config, lib, ... }:

lib.mkIf (config.desktop.environment == "hyprland") {

  programs.hyprland = {
    enable   = true;
    withUWSM = true;
  };

  programs.dsearch.enable = true;

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable           = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN              = true;
    enableDynamicTheming   = true;
    enableAudioWavelength  = true;
    enableCalendarEvents   = true;
  };

  services.displayManager.dms-greeter = {
    enable          = true;
    compositor.name = "hyprland";
    configHome      = "/home/akhil";
  };

}
