{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "pr43") {
  # ── Hyprland compositor ───────────────────────────────────
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # ── XDG desktop portals ───────────────────────────────────
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # ── Login / greeter ───────────────────────────────────────
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

  # ── Audio ─────────────────────────────────────────────────
  # PipeWire is the audio server; the Quickshell bar controls
  # volume via wpctl (from wireplumber).
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  # Disable PulseAudio (conflicts with PipeWire-pulse)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # ── Bluetooth ─────────────────────────────────────────────
  # blueman-applet is autostarted by Quickshell's settings page
  services.blueman.enable = true;

  # ── Power profiles ────────────────────────────────────────
  # Required by the Power page in the Quickshell settings window.
  services.power-profiles-daemon.enable = true;

  # ── Polkit authentication agent ───────────────────────────
  # hyprpolkitagent is the lightweight agent launched in hyprland.lua.
  security.polkit.enable = true;

  # ── Brightness control ────────────────────────────────────
  # Give all users write access to backlight sysfs so brightnessctl
  # works without sudo.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  # ── System packages ───────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # Screenshot pipeline
    grim
    slurp
    imagemagick

    # Wallpaper daemon (awww-daemon, invoked by hyprland.lua)
    awww

    # Network tray applet (nm-applet, autostarted by hyprland.lua)
    networkmanagerapplet

    # Polkit agent used in hyprland.lua autostart
    hyprpolkitagent

    # Lock screen
    hyprlock

    # App launcher + clipboard picker
    rofi

    # Clipboard history daemon
    cliphist
    wl-clipboard

    # Wallpaper-based color generation
    matugen

    # GTK appearance switcher (GUI)
    nwg-look

    # Theming
    adw-gtk3
    papirus-icon-theme

    # Media playback control (used by media keybinds)
    playerctl

    # Brightness control
    brightnessctl

    # Display color temperature
    gammastep

    # Terminal
    kitty

    # File manager + plugins
    thunar
    thunar-volman
    thunar-archive-plugin
    gvfs
    tumbler

    # System monitor / visualisers
    btop
    cava

    # Shell visualiser
    fastfetch

    # Video player
    mpv

    # Quickshell — QML-based desktop shell (bar, notifications, power menu…)
    quickshell
  ];
}
