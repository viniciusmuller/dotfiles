{ pkgs, ... }:

let
  # Base16-shell fork that updates weekly
  base16-shell = pkgs.fetchFromGitHub {
    owner = "fnune";
    repo = "base16-shell";
    rev = "e94ac27230c78c32150bfda9f4427782dd5f9e92";
    sha256 = "sha256-bbp3yRGB5r3m+DJSpTBF5I2Z4Pv7kl6DFj6OY2FwlSE=";
  };

  base16-command = ''
    # Base16 Shell
    BASE16_SHELL=${base16-shell.outPath}
    [ -n "$PS1" ] && \
      [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
  '';
in
{
  programs.bash.initExtra = base16-command;
  programs.zsh.initExtra = base16-command;
}
