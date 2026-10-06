{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      nixcfg  = "cd /etc/nixos && nvim flake.nix";
      # eza aliases — extended to match the 43PR style
      ls = "eza --icons=auto";
      ll = "eza -lah --icons=auto --git";
      la = "eza -a --icons=auto";
      lt = "eza --tree --icons=auto";
      cat = "bat";
    };

    interactiveShellInit = ''
      set -g fish_greeting
      zoxide init fish --cmd cd | source
      fzf --fish | source

      # Starship prompt
      starship init fish | source

      # Monochrome eza colour scheme (mirrors 43PR .zshrc)
      set -x EZA_COLORS "uu=bright-black:gu=bright-black:da=bright-black:ur=white:uw=bright-black:ux=white:ue=bright-black:gr=bright-black:gw=bright-black:gx=white:tr=bright-black:fi=white:di=bright-white:ln=bright-black:pi=bright-black:so=bright-black:bd=bright-black:cd=bright-black:or=bright-black:mi=bright-black:ex=white"
    '';

    # `theme` helper — wraps the 43PR theme.py controller.
    # Only does anything when the dotfiles repo is present (pr43 env);
    # harmless on all other DEs.
    functions.theme = ''python3 $HOME/.config/43pr/bin/theme.py $argv'';
  };

  # Starship — cross-shell prompt used by fish above.
  programs.starship = {
    enable = true;
    # Use starship's own defaults; theme.py may write a starship.toml later.
    settings = {};
  };
}
