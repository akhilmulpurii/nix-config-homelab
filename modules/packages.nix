{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    ghostty
    tmux
    nixd
    nil
    starship
    zoxide
    fzf
    eza
    bat
    delta
    ripgrep
    fd
    nodejs
    zed-editor
    fastfetch

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
