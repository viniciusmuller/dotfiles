# Vim custom keybindings

## Normal keys rebindings
- `t`:
  - `n`: Toggle nvim-tree
  - `l`: Toggle code symbols tree
  - `t`: Toggle trouble-nvim

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
- `gs`: Show type signature help
- `[d:` Go to previous diagnostic
- `]d`: Go to next diagnostic

## Leader key keybindings
- Leader: `<space>`

  - `.`: Find git tracked project files
  - `,`: Find buffers

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
    - `c`: Commits
    - `s`: Substring in files
    - `m`: Man pages
    - `h`: Vim help tags

  - `o`: Open
    - `t`: Terminal

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

  - `d`: Debug
    - `d`: Toggle breakpoint on the current line
    - `D`: Set conditional breakpoint on the current line
    - `l`: Set log point on the current line
    - `f`: Continue until next breakpoint
    - `u`: Toggle debugging UI
    - `r`: Open nvim-dap REPL
    - `j`: Step out
    - `k`: Step into

  - `q`:
    - `r`: Runs code in the file outputting it in a new window. If in visual mode, runs the current selection, otherwise runs the whole file.
