{ pkgs, lib, ... }:

let
  shellConfig = {
    # Source nix
    initExtra = ". ~/.nix-profile/etc/profile.d/nix.sh";
    shellAliases = {
      rb = "home-manager switch --flake '.#wsl'";
    };
  };
in
{
  imports = [
    ../../utils/scripts

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/zsh.nix
    ../../pkgs/nvim
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/htop.nix # Process viewer
    ../../pkgs/keychain.nix # Ssh key caching
    ../../pkgs/gpg.nix
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/bat.nix # File previewer

    ../../services/gpg-agent.nix
  ];

  home.packages = with pkgs; [
    # CLI
    bandwhich # Network inspector
    tealdeer # TLDR of man pages
    ripgrep # File content finder
    fd # File finder
    ncdu # Curses interface for `du`
    file # Shows info about files
    neofetch # Shows system information
    pfetch # Smaller neofetch
    bitwarden-cli
  ];

  programs.bash = shellConfig;
  # Currently using zsh installed via apt
  programs.zsh = lib.mkMerge [ shellConfig { sessionVariables.SHELL = "/bin/zsh"; } ];

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
