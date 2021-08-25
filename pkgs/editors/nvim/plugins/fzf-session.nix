{ pkgs, ... }:

let
  fzf-session = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "fzf-session.vim";
      version = "2021-07-29";

      src = pkgs.fetchFromGitHub {
        owner = "arcticlimer";
        repo = "fzf-session.vim";
        rev = "dd6a28753677e9790d16db56b8d38a7bcf7ff979";
        sha256 = "sha256-GabgJli7XGFJ2lRi8KWvqoknFX5KaN0GpWLik5M0gpg=";
      };

      meta.homepage = "https://github.com/arcticlimer/fzf-session.vim";
    };

    config = ''
      " Creating session directory
      let s:fzf_session_path = '~/.fzf_session'
      call mkdir(expand(s:fzf_session_path), "p")
      let g:fzf_session_path = s:fzf_session_path

      " Keybindings
      nnoremap <leader>ss :Session<space>
      nnoremap <leader>sd :SDelete<space>
      nnoremap <leader>sl :Sessions<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ fzf-session ];
}
