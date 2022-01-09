{ pkgs, inputs, colorscheme, ... }:

with inputs.nix-colors.lib { inherit pkgs; };
{
  programs.neovim.plugins = [
    {
      plugin = vimThemeFromScheme { scheme = colorscheme; };
      config = "colorscheme nix-${colorscheme.slug}";
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
