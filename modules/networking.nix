{ config, pkgs, ... }:

{
  networking = {
    # Hostname for the system
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
    # Firewall configuration
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80   # HTTP
        443  # HTTPS
      ];
    };
  };

  services.openssh.enable = true;
}
