# Random (n)vim notes

## TODO list

### DONE: Give room for icons left of line numbers
2023-03-30: Solved using `vim.o.signcolumn = 'number'`

### DONE: Jump around quickly in the buffer like evil snipe
2023-03-30: Solved using module
[phaazon/hop.nvim](https://www.github.com/phaazon/hop.nvim).

### DONE: Yank stack like emacs
2023-04-12: Solved using plugin
[gbprod/yanky.nvim](https://www.github.com/gbprod/yanky.nvim)

## Ensure a module is installed before configuring it
From Neovim - [Bufferline Buffers vs Tabs vs Windows Explanation](https://www.youtube.com/watch?v=vJAmjAax2H0)

Add this to the top of a file that configures a module:

```lua
local status_ok, example_module = pcall(require, 'example_module')
if not status_ok then
    return

end
```
