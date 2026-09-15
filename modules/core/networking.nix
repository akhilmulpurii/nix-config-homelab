{ ... }:

{
  networking.hostName              = "nixos";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable          = true;
    allowedTCPPorts = [ 80 443 ];
  };

  services.openssh.enable = true;
}
