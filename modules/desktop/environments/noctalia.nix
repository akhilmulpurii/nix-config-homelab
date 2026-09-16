{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.desktop.environment == "noctalia") {
  # Umbriel — the Wayland compositor paired with Noctalia.
  programs.umbriel.enable = true;

  # Noctalia desktop shell: installs the package system-wide and enables the
  # services its wifi/bluetooth/power/battery widgets depend on.
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  # Noctalia Greeter — greetd-based login screen for the session above.
  services.displayManager.noctalia-greeter = {
    enable = true;

    settings = {
      keyboard.layout = "us";
    };

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice";
    };
  };
}
