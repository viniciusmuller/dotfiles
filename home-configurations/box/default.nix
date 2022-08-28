{ pkgs, lib, ... }:

let
  shellConfig = {
    shellAliases = {
      rb = "nix build .#homeConfigurations.box.activationPackage && result/activate";
    };
  };
in
{
  imports = [
    ../../utils/scripts

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/bash.nix # Shell
    # ../../pkgs/starship.nix # Prompt
    ../../pkgs/editors/nvim
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/htop.nix # Process viewer
    ../../pkgs/gpg.nix
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/bat.nix # File previewer

    ../../pkgs/keychain.nix # ssh key caching
    ../../services/gpg-agent.nix
  ];

  home.packages = with pkgs; [
    # CLI
    ripgrep # File content finder
    fd # File finder
    ncdu # Curses interface for `du`
    file # Shows info about files
    neofetch # Shows system information
    pfetch # Smaller neofetch
  ];

  programs.bash = shellConfig;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
