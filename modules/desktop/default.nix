{ lib, ... }:

{
  options.desktop.environment = lib.mkOption {
    type = lib.types.enum [
      "gnome"
      "plasma"
      "cosmic"
      "xfce"
      "cinnamon"
      "budgie"
      "lxqt"
      "noctalia"
      "caelestia"
    ];
    default = "cinnamon";
    description = "The desktop environment / compositor to enable.";
  };

  imports = [
    ./environments/gnome.nix
    ./environments/plasma.nix
    ./environments/cosmic.nix
    ./environments/xfce.nix
    ./environments/cinnamon.nix
    ./environments/budgie.nix
    ./environments/lxqt.nix
    ./environments/noctalia.nix
    ./environments/caelestia.nix
  ];
}
