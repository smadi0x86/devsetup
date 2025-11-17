# Emacs Cheatsheet

## General Commands

- `M-x` (aka `ALT-x`) — Command prompt (e.g., `describe-function`)
- `C-x C-s` — Save buffer
- `C-x C-c` — Exit Emacs
- `C-x C-f` — Find/open file
- `C-x 5 2` — Open new frame (new window)
- `C-x k` — Kill (close) current buffer
- `C-x C-b` — List open buffers
- `C-x C-fd` — Open dired in current directory instantly
- `C-x h` — Highlight all file

## Clipboard

- `M-w` — Copy (ALT-w)
- `C-y` — Paste (yank)
- `C-,` — Duplicate line (if configured)

**Note:** I am using cua mode decalared in `.emacs` file, which uses classic CTRL+C,V,Z, the above commands work with native emacs only. 

## Window Management

- `C-x 2` — Split window horizontally (below)
- `C-x 3` — Split window vertically (right)
- `C-x o` — Move between windows
- `C-x r/l arrow` — Move to next/previous buffer

## Package & Customization

- `M-x list-packages` — List packages
  - In package list: press `i` to mark, `x` to install
- `M-x customize-themes` — Change theme
- `C-x customize-theme` — Another way to change themes
  - Don't forget to save with `C-x C-s`
- `C-x customize-variable → <variable>` — Customize a variable (e.g. `display-line-numbers-type`)

## Magit

- `C-x g` — Open magit status
- When in magit status window you can:
  - `s` to stage a change
  - `cc` to commit staged changes
  - `Ctrl-c Ctrl-c` to confirm commit after writing a message
  - `Pp` to push changes to remote

## Navigation

- `ALT+SHIFT .` — Go to last line
- `ALT+SHIFT ,` — Go to first line
- `C-h o` — Describe function
- `C-x b` — Switch buffer by name

## Dired Mode

- `C-x d` — Enter Dired (directory browser)
- In Dired:
  - `C-x C-q` — Enable editing of file names
  - `C-c C-c` — Save changes
  - `C-c ESC` — Discard changes

## Highlighting

- `Ctrl+Shift + Arrow` — Begin highlighting (selecting)
- `Shift + Arrow` — Extend highlight to end of line or char

_Notes:_
- `C-` means hold **Control**
- `M-` means hold **Alt** (Meta key)
- `RET` = Enter
