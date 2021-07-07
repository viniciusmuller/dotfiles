# Vim custom keybindings

## Normal keys rebindings
- `t`:
  - `n`: Toggle nvim-tree
  - `q`: Toggle quickfix list
  - `l`: Toggle location list
  - `l`: Toggle code symbols tree

- `[`:
  - `q`: Go to previous element on the quickfix list
  - `Q`: Go to the first element on the quickfix list

  - `w`: Go to previous element in a location list
  - `W`: Go to the first element in a location list

- `]`:
  - `q`: Go to next element on the quickfix list
  - `Q`: Go to the last element on the quickfix list

  - `w`: Go to next element in a location list
  - `W`: Go to the last element in a location list

- `H`: Same as `^`
- `L`: Same as `$`
- `Q`: Same as `@@`, repeats last macro
- `<C-q>`: Same as <C-w>q
- `<C-s>`: `:update` buffer
- `<C-g>`: Same as ``` ``
- `<C-g><C-g>`: Same as `` `" ``, jumps to last position in file.


## Language server keybindings
> These keys are added/overriden when there is a language server client attached:
- `gr`:
- `K`: Hover symbol on the cursor
- `gd`: Go to definition
- `gi`: Go to implementation
- `gD`: Go to declaration
- `<C-k>`: Show type signature help
- `[d:` Go to previous diagnostic
- `]d`: Go to next diagnostic

## Leader key keybindings
- Leader: `<space>`
  - `t`: Tabs and testing

    > Tests
    - `f`: Run tests in the current file
    - `s`: Run test suite
    - `l`: Run last test
    - `n`: Run test on the cursor
    - `v`: Jump to where last test ran
    - `D`: Go to type definition

    > Tabs
    - `o`: Prompts to open a new tab
    - `q`: Closes the current tab
    - `<`: Moves the current tab to the left
    - `>`: Moves the current tab to the right

  - `f`: Find
    - `f`: Files
    - `b`: Buffers
    - `c`: Commits
    - `s`: Substring in files
    - `m`: Mappings
    - `h`: Vim help tags

  - `l`: Language server
    > These keybindings are only avaiable when there is a language server attached
    - `f`: Format current buffer
    - `r`: Rename symbol on the cursor
    - `a`: Request code action on the cursor
    - `q`: Open diagnostics in a location list
    - `d`: Open a popup with current diagnostic

  <!-- TODO: Maybe add about workspaces -->

  - `p`: Project
    - `t`: Lists project TODOs on a location list
    - `a`: Jumps to alternate file in a new buffer

  - `g`: Git
    - `g`: Opens vim-fugitive menu
    - `m`: Shows git commit message of the current line
    - `d`: Opens split diff of the current file
    - `l`: Shows git commit log
    - `b`: Open git branches fuzzy menu
    - `t`: Open git tags fuzzy menu

  - `v`: Vim
    - `r`: Reload the configuration
    - `q`: Quit vim, stopping if there are unsaved buffers
    - `Q`: QUIT vim, ignoring any unsaved buffers
