{ pkgs, prelude, ... }:

let
  aliases = {
    gw = "git worktree";
    gs = "git status";
    gc = "git commit";
    gl = "git log";
    gcl = "git clone";
    gco = "git checkout";
    glg = "git log --graph --oneline";
    gd = "git diff";
    gds = "git diff --staged";
    ga = "git add";
    gr = "git remote";
    grv = "git remote -v";
    gra = "git remote add";
    gp = "git push";
    gpl = "git pull";
    gb = "git branch";
    grs = "git restore";
    gsh = "git show";
  };
in
{
  programs.bash.shellAliases = aliases;

  programs.git = {
    enable = true;

    userName = "Vinícius Müller";
    userEmail = "vinigm.nho@gmail.com";
    package = pkgs.gitFull;

    signing.key = "0x297A9768C8CA96AB";
    signing.signByDefault = true;

    extraConfig = {
      core.editor = "vim";
      pull.rebase = true;
      merge.conflictstyle = "diff3";
      init.defaultBranch = "main";
    };

    # Global ignores
    ignores = [
      "*~" 
      "*.swp"
      ".envrc"
      ".direnv"
    ];

    delta = {
      enable = true;
      options = {
        features = "line-numbers decorations";
        syntax-theme = "gruvbox-dark";
        plus-style = ''syntax "#003800"'';
        minus-style = ''syntax "#3f0001"'';
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
          hunk-header-decoration-style = "cyan box ul";
        };
        delta = {
          navigate = true;
        };
      };
    };
  };
}
