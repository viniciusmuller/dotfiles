{ pkgs, username, ... }:

let 
  i3blocks-contrib = pkgs.fetchFromGitHub {
    owner = "vivien";
    repo = "i3blocks-contrib";
    rev = "07dbf036882c513b58e7d18d48eb6f08493f5717";
    sha256 = "sha256-i9xSYo7BkYfzDqgwOEOtYtCYblJI5ldc1oBgX9EVQqA=";
  };
in
{
  # Make i3-sensible-terminal respect kitty
  environment.sessionVariables.TERMINAL = [ "kitty" ];

  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
      ];
      configFile = ./i3config;
    };
  };

  home-manager.users.${username} = {
    home.file.".i3blocks.conf".source = ./i3blocks.toml;
    # home.file.".config/i3blocks".source = i3blocks-contrib; 
  };
}
