{ config, pkgs, ... }:

{
  users.users."akhil" = {
    isNormalUser = true;
    description  = "Akhil Mulpuri";
    extraGroups  = [ "networkmanager" "wheel" ];
    shell        = pkgs.fish;
    packages     = with pkgs; [];
  };
}
