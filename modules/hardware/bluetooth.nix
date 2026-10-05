{ pkgs,... }:

{
  hardware.enableRedistributableFirmware = true;

  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    usbutils
  ];

  services.blueman.enable = true;
}
