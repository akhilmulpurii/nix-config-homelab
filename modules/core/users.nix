{ pkgs, ... }:

{
  users.groups.akhil = { };

  users.users.akhil = {
    isNormalUser = true;
    description = "Akhil Mulpuri";
    group = "akhil";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };
}
