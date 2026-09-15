{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim   # text editor (also the fallback for editing configuration.nix)
    wget
    ghostty
  ];

  programs.git = {
    enable = true;
    config = {
      user.name          = "Akhil Mulpuri";
      user.email         = "akhilfilms02@gmail.com";
      init.defaultBranch = "main";
      pull.rebase        = true;
      push.autoSetupRemote = true;
    };
  };
}
