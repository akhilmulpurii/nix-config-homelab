{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "caelestia") {
  # Hyprland — the window manager Caelestia's shell is built for.
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Caelestia ships no greeter of its own; the project recommends greetd
  # with tuigreet for logging into the Hyprland session. See:
  # https://github.com/caelestia-dots/caelestia#usage
  services.greetd = {
    enable = true;
    settings.default_session.command = lib.concatStringsSep " " [
      (lib.getExe pkgs.tuigreet)
      "--time"
      "--remember"
      "--remember-user-session"
      "--asterisks"
      "--user-menu"
      "--user-menu-min-uid 1000"
      "--sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
      "--power-shutdown 'shutdown -P now'"
      "--power-reboot 'shutdown -r now'"
    ];
  };
}
