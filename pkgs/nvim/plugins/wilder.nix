{ pkgs, ... }:

let
  wilder = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "wilder-nvim";
      version = "2021-07-31";

      src = pkgs.fetchFromGitHub {
        owner = "gelguy";
        repo = "wilder.nvim";
        rev = "3b8bcae3c3c1ec2c312ed9065935c9fc3940bcb3";
        sha256 = "sha256-hyK4zQzpu9Buhyie/hh0f37I8L1QfBVD0+uXSgoikLg=";
      };
    };
    config = ''
      call wilder#enable_cmdline_enter()

      set wildcharm=<Tab>
      cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
      cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

      call wilder#set_option('modes', ['/', '?', ':'])

      let s:highlighters = [
              \ wilder#pcre2_highlighter(),
              \ wilder#basic_highlighter(),
              \ ]

      call wilder#set_option('pipeline', [
            \   wilder#branch(
            \     wilder#cmdline_pipeline({
            \       'fuzzy': 1,
            \     }),
            \     wilder#python_search_pipeline({
            \       'pattern': 'fuzzy',
            \     }),
            \   ),
            \ ])

      call wilder#set_option('renderer', wilder#renderer_mux({
            \ ':': wilder#popupmenu_renderer({
            \   'highlighter': s:highlighters,
            \ }),
            \ '/': wilder#wildmenu_renderer({
            \   'highlighter': s:highlighters,
            \ }),
            \ }))
    '';
  };
in
{
  programs.neovim.plugins = [ wilder ];
}
