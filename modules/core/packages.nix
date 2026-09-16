{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # editors
    neovim
    zed-editor

    # shell utilities
    wget
    tmux
    eza
    bat
    delta
    ripgrep
    fd
    fzf
    zoxide
    fastfetch
    ghostty
    btop
    gcc

    # nix tooling
    nixd
    nil

    # development
    nodejs
    github-copilot-cli

    # apps for navigating os
    brave
    nautilus
    thunderbird
    qimgv
    vlc
  ];
}
