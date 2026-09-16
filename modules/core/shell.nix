{ ... }:

# Enables fish as a valid login shell system-wide (registers it in
# /etc/shells and generates completions for system packages).
#
# Per-user customization (aliases, interactive init, etc.) lives in
# home-manager: see ./home/akhil/modules/shell.nix
{
  programs.fish.enable = true;
}
