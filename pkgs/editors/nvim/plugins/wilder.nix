{ pkgs, ... }:

let
  wilder = {
    plugin = pkgs.vimPlugins.wilder-nvim;
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
