{ lib, osConfig, ... }:

# Only active when `desktop.environment == "noctalia"` (see
# ../../../modules/desktop/environments/noctalia.nix, which installs the
# Noctalia + Umbriel packages system-wide and enables the greeter).
lib.mkIf (osConfig.desktop.environment == "noctalia") {
  programs.noctalia = {
    enable = true;
    # Already installed system-wide; avoid a second copy in the user profile.
    package = null;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };
  };

  # Umbriel — the compositor Noctalia is paired with. This autostarts
  # Noctalia and applies the appearance/window/layer rules + IPC keybinds
  # recommended at
  # https://docs.noctalia.dev/noctalia/compositor-settings/umbriel/
  xdg.configFile."umbriel/config.toml".text = ''
    [general]
    autostart = ["noctalia"]

    [appearance]
    prefer_no_csd = true
    border_width = 2
    corner_radius = 10

    [appearance.blur]
    enabled = true
    optimized = true
    passes = 3
    radius = 3
    noise = 0.02
    brightness = 0.9
    contrast = 0.9
    saturation = 1.1

    # Blur all windows
    [[window_rule]]
    blur = true
    blur_optimized = true

    # Float Noctalia's settings window
    [[window_rule]]
    match.app_id = "^dev.noctalia.Noctalia$"
    default_floating = true
    default_size = [1020, 900]

    [[layer_rule]]
    match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
    blur = true
    blur_ignore_alpha = 0.5
    blur_optimized = false

    [keybinds]
    "Mod+Space" = "spawn:noctalia msg panel-toggle launcher"
    "Mod+S" = "spawn:noctalia msg panel-toggle control-center"
    "Mod+Comma" = "spawn:noctalia msg settings-toggle"
    "Alt+Tab" = "spawn:noctalia msg window-switcher"
    "Mod+Shift+A" = "spawn:noctalia msg screenshot-annotate"
    "Mod+Ctrl+A" = "spawn:noctalia msg annotate"

    "XF86AudioRaiseVolume" = "spawn:noctalia msg volume-up"
    "XF86AudioLowerVolume" = "spawn:noctalia msg volume-down"
    "XF86AudioMute" = "spawn:noctalia msg volume-mute"
    "XF86MonBrightnessUp" = "spawn:noctalia msg brightness-up"
    "XF86MonBrightnessDown" = "spawn:noctalia msg brightness-down"
  '';
}
