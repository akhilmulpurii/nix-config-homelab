{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "cosmic") {

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };

  environment.cosmic.excludePackages = (
    with pkgs;
    [
      firefox
      cosmic-term
      cosmic-store
      cosmic-files
      cosmic-edit
      cosmic-player
    ]
   );

}
