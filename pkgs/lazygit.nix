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

  programs.bash.shellAliases.lg = "lazygit";
}
