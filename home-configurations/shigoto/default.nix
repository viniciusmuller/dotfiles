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
    # ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/direnv.nix
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/bat.nix # File previewer

    # Services
    # ../../services/gpg-agent.nix
    # ../../services/dunst.nix
  ];

  home.packages = with pkgs; [
    neofetch # Shows system information
    pfetch # Smaller neofetch
    claude-code
  ];

  programs.bash = {
    # Source nix
    # initExtra = ". ~/.nix-profile/etc/profile.d/nix.sh";
    shellAliases = {
      rb = "nix build .#homeConfigurations.shigoto.activationPackage && result/activate";
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

