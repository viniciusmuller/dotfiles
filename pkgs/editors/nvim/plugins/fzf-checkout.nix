{ pkgs, ... }:

let
  fzf-checkout = {
    plugin = pkgs.vimPlugins.fzf-checkout-vim;

    config = ''
      let g:fzf_checkout_git_options = '--sort=-committerdate'
      let g:fzf_tag_actions = {
      \ 'checkout': {'execute': '!{git} -C {cwd} checkout {branch}'},
      \}

      nnoremap <leader>gb <cmd>GBranches<cr>
      nnoremap <leader>gt <cmd>GTags<cr>
    '';
  };

in
{
  programs.neovim.plugins = [ fzf-checkout ];
}
