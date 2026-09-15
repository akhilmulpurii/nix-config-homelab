{ ... }:

# ============================================================
#  System Configuration
#  Hostname: nixos  |  User: akhil  |  NixOS 26.05
# ============================================================

{
  imports = [
    ./hardware-configuration.nix

    # Core system
    ./modules/core/boot.nix
    ./modules/core/locale.nix
    ./modules/core/networking.nix
    ./modules/core/users.nix
    ./modules/core/packages.nix
    ./modules/core/shell.nix
    ./modules/core/fonts.nix
    ./modules/core/services.nix

    # Hardware
    ./modules/hardware/nvidia.nix
    ./modules/hardware/filesystem.nix

    # Desktop — toggle with `desktop.environment` below
    ./modules/desktop/default.nix

    # Services
    ./modules/services/docker.nix
    ./modules/services/samba.nix
  ];

  # ── Desktop environment ──────────────────────────────────
  # Options: "hyprland" "gnome" "plasma"
  desktop.environment = "plasma";
  # ─────────────────────────────────────────────────────────

  # Do NOT change stateVersion after initial install.
  system.stateVersion = "26.05";
}
