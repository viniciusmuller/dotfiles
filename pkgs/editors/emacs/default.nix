{ pkgs, inputs, ... }:

let
  emacsPackaging = pkgs.emacsPackagesNg;
  my-emacs = ((pkgs.emacsPackagesFor pkgs.emacsGit).emacsWithPackages (epkgs: with epkgs; [
      use-package

      # Usability
      vterm
      marginalia
      vertico
      consult
      corfu
      multiple-cursors
      transpose-frame
      projectile
      swiper
      perspective
      magit
      lsp-ui
      yasnippet
      yasnippet-snippets
      smartparens
      # pdf-tools
      ace-window

      # Fuzzy finding
      orderless # fuzzy completion for minibuffer
      
      # elsa # Linting Engine (currently broken on emacs 28+)
      flycheck
      flycheck-elsa
      flymake-flycheck

      # Modes
      nix-mode
      lsp-mode
      elixir-mode

      # Aesthetics
      diff-hl
      lsp-treemacs
      dashboard
      all-the-icons
      doom-modeline
      rainbow-delimiters

      # Org
      org-roam
      org-bullets

      evil
      evil-org
    ] ++ (with epkgs.elpaPackages; [ yasnippet-classic-snippets ])));
in
{
  home.packages = [
    my-emacs
    pkgs.emacs-all-the-icons-fonts
  ];

  home.file.".emacs.d/init.el".text = builtins.readFile ./default.el;
  home.file.".emacs.d/theme.el".text = builtins.readFile ./theme.el;
  services.emacs.enable = true;
  services.emacs.package = my-emacs;
}
