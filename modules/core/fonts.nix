{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      # Nerd Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      nerd-fonts.iosevka
      # Standard fonts
      roboto-mono
      font-awesome
    ];

    fontconfig.defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font"
        "MesloLGS NF"
        "Iosevka Nerd Font"
      ];
    };
  };
}
