{ lib, osConfig, inputs, ... }:

{
  imports = [ inputs.caelestia-shell.homeManagerModules.default ];

  config = lib.mkIf (osConfig.desktop.environment == "caelestia") {
    programs.caelestia = {
      enable = true;
      cli.enable = true;

      settings = {
        paths.wallpaperDir = "~/Pictures/Wallpapers";
      };
    };
  };
}
