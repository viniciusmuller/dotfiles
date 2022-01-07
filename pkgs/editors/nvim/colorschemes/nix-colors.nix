{ pkgs, inputs, config, ... }:

with inputs.nix-colors.lib { inherit pkgs; };
{
  programs.neovim.plugins = [
    {
      plugin = vimThemeFromScheme { scheme = config.colorscheme; };
      config = "colorscheme nix-${config.colorscheme.slug}";
    }
  ];

  xdg.configFile."nvim/init.vim".onChange =
    let
      nvr = "${pkgs.neovim-remote}/bin/nvr";
    in
    ''
      ${nvr} --serverlist | while read server; do
        ${nvr} --servername $server --nostart -c ':so $MYVIMRC' & \
      done
    '';
}
