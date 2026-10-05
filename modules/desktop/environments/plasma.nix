{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "plasma") {

  services = {
    # Enable the Plasma 6 desktop environment
    desktopManager.plasma6.enable = true;

    # Enable the SDDM display manager (recommended for Plasma)
    displayManager.sddm.enable = true;

    # Enable Wayland session in SDDM (default for Plasma 6)
    displayManager.sddm.wayland.enable = true;

  };

  # Disable KWallet so it does not compete with gnome-keyring (our global
  # Secret Service provider). Applications will use gnome-keyring instead.
  security.pam.services.kwallet.enable = lib.mkForce false;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    gwenview
    okular
    kate
    ffmpegthumbs
    krdp
    dolphin
  ];

}
