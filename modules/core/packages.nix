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

    # keychain — Secret Service provider shared across all DEs
    gnome-keyring   # the daemon (also provides the D-Bus service)
    seahorse        # GUI keyring manager (view/edit/delete stored secrets)
    libsecret       # client library used by most apps to access the keyring
  ];
}
