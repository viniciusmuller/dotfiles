{ ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta";
        };
      };
      startupPopupVersion = 1;
      reporting = "off";
    };
  };

  programs.zsh.shellAliases.lg = "lazygit";
  programs.bash.shellAliases.lg = "lazygit";
  programs.fish.shellAliases.lg = "lazygit";
}
