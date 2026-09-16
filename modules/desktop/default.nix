{ config, lib, ... }:

{
  options.desktop.environment = lib.mkOption {
    type = lib.types.enum [
      "dank"
      "gnome"
      "plasma"
      "cosmic"
      "xfce"
    ];
    default = "dank";
    description = "The desktop environment / compositor to enable.";
  };

  imports = [
    ./environments/dank.nix
    ./environments/gnome.nix
    ./environments/plasma.nix
    ./environments/cosmic.nix
    ./environments/xfce.nix
  ];
}
