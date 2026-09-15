{ ... }:

{
  # Docker
  virtualisation.docker.enable = true;
  users.users.akhil.extraGroups = [ "docker" ];

  # Nvidia Container Toolkit
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;
}
