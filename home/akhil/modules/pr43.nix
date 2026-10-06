{ lib, osConfig, pkgs, config, ... }:

# Home-Manager module for the 43PR Hyprland dotfiles.
lib.mkIf (osConfig.desktop.environment == "pr43") {

  # ── User-level packages ──────────────────────────────────
  home.packages = with pkgs; [
    python3
  ];

  # ── Session variables ────────────────────────────────────
  home.sessionVariables = {
    XCURSOR_SIZE       = "14";
    QT_QPA_PLATFORM    = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # ── XDG config files ─────────────────────────────────────

  xdg.configFile = {
    # Hyprland Lua config (hyprland.lua, keybinds.lua, look.lua,
    "hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/hypr";
      recursive = true;
    };

    # Quickshell QML shell (bar, notifications, power menu, etc.)
    "quickshell" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/quickshell";
      recursive = true;
    };

    # Rofi (layout + style; colors.rasi is generated at runtime)
    "rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/rofi";
      recursive = true;
    };

    # Kitty terminal (kitty.conf; matugen.conf is generated at runtime)
    "kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/kitty";
      recursive = true;
    };

    # Matugen template configuration
    "matugen" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/matugen";
      recursive = true;
    };

    # GTK 3 theming (settings.ini + colors.css stub; colors.css is runtime)
    "gtk-3.0" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/gtk-3.0";
      recursive = true;
    };

    # GTK 4 theming
    "gtk-4.0" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/gtk-4.0";
      recursive = true;
    };

    # nwg-look appearance config
    "nwg-look" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/nwg-look";
      recursive = true;
    };

    # btop system monitor config
    "btop" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/btop";
      recursive = true;
    };

    # cava audio visualiser config
    "cava" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/cava";
      recursive = true;
    };

    # fastfetch system info config
    "fastfetch" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/fastfetch";
      recursive = true;
    };

    # 43pr scripts (theme.py, etc.)
    "43pr" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/.config/43pr";
      recursive = true;
    };
  };

  # ── Activation: clone repo + bootstrap theme ──────────────
  home.activation.clone43prDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    DOTFILES_DIR="$HOME/dotfiles"

    if [ ! -d "$DOTFILES_DIR/.git" ]; then
      $DRY_RUN_CMD ${lib.getExe pkgs.git} clone \
        https://github.com/43PR/dotfiles.git \
        "$DOTFILES_DIR"
      $VERBOSE_ECHO "Cloned 43PR dotfiles to $DOTFILES_DIR"
    else
      $VERBOSE_ECHO "43PR dotfiles already present at $DOTFILES_DIR, skipping clone."
    fi

    # Create expected user directories
    $DRY_RUN_CMD mkdir -p "$HOME/Pictures/Wallpapers"
    $DRY_RUN_CMD mkdir -p "$HOME/Videos"

    # Bootstrap theme colors on first install (generated files don't exist yet)
    THEME_PY="$HOME/.config/43pr/bin/theme.py"
    COLORS_CHECK="$HOME/.config/kitty/matugen.conf"
    if [ -f "$THEME_PY" ] && [ ! -f "$COLORS_CHECK" ]; then
      $VERBOSE_ECHO "Running initial theme.py apply..."
      $DRY_RUN_CMD ${pkgs.python3}/bin/python3 "$THEME_PY" apply || true
    fi
  '';
}
