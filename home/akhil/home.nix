{ ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/noctalia.nix
    ./modules/caelestia.nix
  ];

  home.username = "akhil";
  home.homeDirectory = "/home/akhil";

  # Do NOT change stateVersion after initial install.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
