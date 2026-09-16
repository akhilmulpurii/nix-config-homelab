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
    # Intentionally excluding a few packages the DE considers "core"
    # (cosmic-term/cosmic-files/cosmic-edit) in favor of ghostty/nautilus/zed-editor.
    desktopManager.cosmic.showExcludedPkgsWarning = false;
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
