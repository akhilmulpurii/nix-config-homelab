{ config, pkgs, ... }:

{
  users.groups.akhil = {};

  users.users."akhil" = {
    isNormalUser = true;
    description  = "Akhil Mulpuri";
    group = "akhil";
    extraGroups  = [ "networkmanager" "wheel" ];
    shell        = pkgs.fish;
    packages     = with pkgs; [];
  };
}
