{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable    = true;
    withUWSM  = true;
  };

  programs.dsearch.enable = true;

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable           = true;
      restartIfChanged = true;
    };

    # Core Features
    enableSystemMonitoring = true;
    enableVPN              = true;
    enableDynamicTheming   = true;
    enableAudioWavelength  = true;
    enableCalendarEvents   = true;
  };

  services.displayManager.dms-greeter = {
    enable         = true;
    compositor.name = "hyprland";
    configHome     = "/home/akhil";
  };
}
