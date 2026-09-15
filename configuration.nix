{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/desktop.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/shell.nix
    ./modules/services.nix
    ./modules/docker.nix
    ./modules/nvidia.nix
    ./modules/filesystem.nix
  ];

  # This value defines the first NixOS version installed on this machine.
  # Do NOT change it after the initial install — see `man configuration.nix`
  # or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";
}
