{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "dank") {
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  # Enable DMS Search
  programs.dsearch.enable = true;
  # Enable DMS Shell
  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };
  # Greeter for Hyprland
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/akhil";
  };
  # Custom Cursor Config
  environment.systemPackages = [
    pkgs.bibata-cursors
  ];
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Original-Ice";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Original-Ice";
    HYPRCURSOR_SIZE = "24";
  };
}
