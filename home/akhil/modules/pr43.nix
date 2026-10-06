{ lib, osConfig, pkgs, config, ... }:

# Home-Manager module for the 43PR Hyprland dotfiles.
#
# Strategy: "live repo" approach — the dotfiles repo is cloned once to
# ~/dotfiles and Home-Manager points xdg.configFile entries at it via
# mkOutOfStoreSymlink.  This mirrors the upstream symlink-based workflow,
# lets you `git pull && theme apply` without a rebuild, and keeps every
# edit live instantly.
#
# Runtime-generated files (theme colors for kitty, GTK, hyprlock, rofi)
# are written by `theme.py` at runtime and are intentionally NOT managed
# by Home-Manager, so they survive rebuilds.

lib.mkIf (osConfig.desktop.environment == "pr43") {

  # ── User-level packages ──────────────────────────────────
  home.packages = with pkgs; [
    # Required by theme.py (the `theme` fish function in shell.nix)
    python3
  ];

  # ── Session variables ────────────────────────────────────
  # Mirrors the hl.env() calls in hyprland.lua so the values are
  # available to every systemd user service and login shell too.
  home.sessionVariables = {
    XCURSOR_SIZE       = "14";
    QT_QPA_PLATFORM    = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # ── XDG config files ─────────────────────────────────────
  # Each entry is a symlink into ~/dotfiles/.config/<dir> via
  # mkOutOfStoreSymlink, keeping the repo as the single source of
  # truth (identical to the Arch symlink strategy).
  #
  # Runtime-generated files (matugen.conf, colors.css, colors.rasi,
  # hyprlock-colors.conf) are NOT listed here — they are written by
  # `theme.py` and must remain mutable.

  xdg.configFile = {
    # Hyprland Lua config (hyprland.lua, keybinds.lua, look.lua,
    # rules.lua, monitors.lua, hyprland-gui.lua, scripts/)
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
  # Runs after every `nixos-rebuild switch` / `home-manager switch`.
  # • Clones the dotfiles repo on first install (skips if already present).
  # • Runs `theme.py apply` once so the generated color files exist before
  #   the first Hyprland session starts.
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
