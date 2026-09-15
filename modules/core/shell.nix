{ ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      nixcfg = "cd /etc/nixos && nvim configuration.nix";
      ls = "eza --icons=auto";
      ll = "eza -la --icons=auto";
      cat = "bat";
    };

    interactiveShellInit = ''
      set -g fish_greeting
      zoxide init fish --cmd cd | source
      fzf --fish | source
    '';
  };
}
