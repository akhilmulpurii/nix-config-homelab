{ config, pkgs, ... }:

{
  services.printing.enable = true;
  services.cockpit = {
    enable = true;
  };

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
