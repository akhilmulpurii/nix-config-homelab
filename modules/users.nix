{ config, pkgs, ... }:

{
  users.users."akhil" = {
    isNormalUser = true;
    description  = "Akhil Mulpuri";
    extraGroups  = [ "networkmanager" "wheel" ];
    packages     = with pkgs; [];
  };
}
