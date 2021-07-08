{ pkgs, ... }:

let
  # TODO: This workaround was needed since the spinner package used by
  # the overlay was returning 404 from elpa.
  spinner-lzip = builtins.fetchurl {
    url = "https://elpa.gnu.org/packages/spinner-1.7.3.el.lz";
    sha256 = "188i2r7ixva78qd99ksyh3jagnijpvzzjvvx37n57x8nkp8jc4i4";
  };
in
{
  programs.doom-emacs.emacsPackagesOverlay = self: super: {
    spinner = super.spinner.override {
      elpaBuild = args: super.elpaBuild (
        args // {
          src = pkgs.runCommandLocal "spinner-1.7.3.el" {} ''
            ${pkgs.lzip}/bin/lzip -d -c ${spinner-lzip} > $out
          '';
        }
      );
    };
  };

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    # TODO: Use emacsGcc here
    # emacsPackage = pkgs.emacsGcc;
  };

  # TODO: Enable emacs service
  # services.emacs = {
  #   enable = true;
  #   package = programs.emacs.package;
  # };
}
