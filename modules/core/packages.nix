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

    # nix tooling
    nixd
    nil

    # development
    nodejs
  ];

  programs.git = {
    enable = true;
    config = {
      user.name            = "Akhil Mulpuri";
      user.email           = "akhilfilms02@gmail.com";
      init.defaultBranch   = "main";
      pull.rebase          = true;
      push.autoSetupRemote = true;
    };
  };
}
