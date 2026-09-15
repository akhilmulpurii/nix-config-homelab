{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs.nerd-fonts; [
      jetbrains-mono
      meslo-lg
    ];

    fontconfig.defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font"
        "MesloLGS NF"
      ];
    };
  };
}
