{ config, lib, ... }:

{
  options.desktop.environment = lib.mkOption {
    type        = lib.types.enum [ "hyprland" ];
    default     = "hyprland";
    description = "The desktop environment / compositor to enable.";
  };

  imports = [
    ./environments/hyprland.nix
    # Add new environments here as you create them, e.g.:
    # ./environments/gnome.nix
    # ./environments/plasma.nix
  ];
}
