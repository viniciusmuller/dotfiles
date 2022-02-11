{ pkgs, ... }:

{
  imports = [
    ../../utils/scripts

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/bash.nix
    ../../pkgs/editors/nvim
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/direnv.nix
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/htop.nix # Process viewer
    ../../pkgs/keychain.nix
    ../../pkgs/gpg.nix
    ../../pkgs/hexchat.nix
    ../../pkgs/bat.nix # File previewer

    # Services
    ../../services/gpg-agent.nix
    # ../../services/dunst.nix

    # GUI
    # ../../pkgs/kitty.nix
    ../../pkgs/chromium.nix # Web browser
    # ../../pkgs/bitwarden.nix # Password manager
    # ../../pkgs/blugon # Screen temperature manager
  ];

  home.packages = with pkgs; [
    # GUI
    spotify

    # CLI
    ncdu # Curses interface for `du`
    file # Shows info about files
    neofetch # Shows system information
    pfetch # Smaller neofetch
  ];

  programs.bash = {
    # Source nix
    # initExtra = ". ~/.nix-profile/etc/profile.d/nix.sh";
    shellAliases = {
      rb = "nix build .#homeConfigurations.arch.activationPackage && result/activate";
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  # Make home-manager work better on non-NixOS distros
  targets.genericLinux.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
