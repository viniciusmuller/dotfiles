{ pkgs, inputs, ... }:

let
  emacsPackaging = pkgs.emacsPackagesNg;
  # my-emacs-with-packages = (pkgs.emacsPackagesFor pkgs.emacsGit).emacsWithPackages
  #   (epkgs: [
  #     (emacsPackaging.trivialBuild {
  #       pname = "emacscool";
  #       version = "1970-01-01";

  #       src = ./.;
  #       packageRequires = (with epkgs.melpaPackages; [
  #         use-package

  #         # Usability
  #         linum-relative

  #         # Aesthetic
  #         dashboard
  #         all-the-icons

  #         # Org
  #         # org-roam
  #         org-bullets

  #         evil
  #       ]);
  #     })
  #   ]);
in
{
  home.packages = [
    ((pkgs.emacsPackagesFor pkgs.emacsGit).emacsWithPackages (epkgs: with epkgs; [
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
      elsa
      flycheck
      flycheck-elsa
      flymake-flycheck
      vertico
      marginalia

      # Modes
      nix-mode
      lsp-mode

      # Aesthetics
      diff-hl
      lsp-treemacs
      dashboard
      all-the-icons
      doom-modeline
      rainbow-delimiters
      gruvbox-theme

      # Org
      org-roam
      org-bullets

      evil
    ] ++ (with epkgs.elpaPackages; [ yasnippet-classic-snippets ])))
    pkgs.emacs-all-the-icons-fonts
  ];

  home.file.".emacs.d/init.el".text = builtins.readFile ./default.el;
  home.file.".emacs.d/theme.el".text = builtins.readFile ./theme.el;
  # services.emacs.enable = true;
}

# emacsPackaging.trivialBuild
# {
# pname = "myInit";
# version = "1970-01-01";

# src = ./.;
# packageRequires =
#   (with epkgs.melpaPackages; [
#     org-roam
#     perspective-exwm
#     perspective
#     all-the-icons
#     cider
#     clojure-mode
#     company-coq
#     company-erlang
#     company-quickhelp
#     csharp-mode
#     dashboard
#     diff-hl
#     doom-modeline
#     elsa
#     erlang
#     eshell-syntax-highlighting
#     flycheck
#     flycheck-elsa
#     flymake-flycheck
#     fsharp-mode
#     fstar-mode
#     haskell-mode
#     haskell-snippets
#     helm
#     hy-mode
#     lfe-mode
#     linum-relative
#     # lsp-haskell
#     scala-mode
#     lsp-metals
#     lsp-mode
#     lsp-treemacs
#     lsp-ui
#     magit
#     multi-term
#     multiple-cursors
#     nix-mode
#     ob-sml
#     org-bullets
#     org-super-agenda
#     pastelmac-theme
#     exotica-theme
#     plantuml-mode
#     projectile
#     rainbow-delimiters
#     request
#     sly
#     sml-basis
#     sml-modeline
#     transpose-frame
#     tuareg
#     use-package
#     yasnippet
#     yasnippet-snippets
#     dmenu
#   ]) ++ (with epkgs.elpaPackages; [
#     yasnippet-classic-snippets
#     sml-mode
#     exwm
#   ]);
# })

# org-roam
# perspective-exwm
# perspective
# all-the-icons
# cider
# clojure-mode
# company-coq
# company-erlang
# company-quickhelp
# csharp-mode
# dashboard
# diff-hl
# doom-modeline
# elsa
# erlang
# eshell-syntax-highlighting
# flycheck
# flycheck-elsa
# flymake-flycheck
# fsharp-mode
# fstar-mode
# haskell-mode
# haskell-snippets
# helm
# hy-mode
# lfe-mode
# linum-relative
# # lsp-haskell
# scala-mode
# lsp-metals
# lsp-mode
# lsp-treemacs
# lsp-ui
# magit
# multi-term
# multiple-cursors
# nix-mode
# ob-sml
# org-bullets
# org-super-agenda
# pastelmac-theme
# exotica-theme
# plantuml-mode
# projectile
# rainbow-delimiters
# request
# sly
# sml-basis
# sml-modeline
# transpose-frame
# tuareg
# use-package
# yasnippet
# yasnippet-snippets
# dmenu
