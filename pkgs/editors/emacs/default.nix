{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    # TODO: Use this when switch back to upstream HM
    # extraConfig = builtins.readFile ./init.el;
    extraPackages = epkgs: with epkgs; [
      # Oh yeah vim
      evil
      evil-leader
      evil-collection
      evil-surround
      evil-commentary
      better-jumper
      undo-tree
      smartparens
      git-gutter

      # Fuzzy finding
      # helm
      # projectile

      treemacs

      # Modes
      nix-mode

      # Completion
      company
      ivy
      counsel

      # Aesthetic
      doom-themes
      rainbow-delimiters
      hl-todo

      # lisp lisp lisp
      slime
    ];
  };

  home.file.".emacs.d/init.el".source = ./init.el;
}
