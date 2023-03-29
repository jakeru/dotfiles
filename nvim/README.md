# Random (n)vim notes

## Ensure a module is installed before configuring it
From Neovim - [Bufferline Buffers vs Tabs vs Windows Explanation](https://www.youtube.com/watch?v=vJAmjAax2H0)

Add this to the top of a file that configures a module:

```lua
local status_ok, example_module = pcall(require, 'example_module')
if not status_ok then
    return

end
```
