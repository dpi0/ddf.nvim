# `ddf.nvim`

Shows a simple delta diff b/w the working tree and the staging area for the current buffer in fullscreen.

> [!WARNING]
> Built with ChatGPT 5.2 (Go Plan).

## Requirements

[Neovim](https://github.com/neovim/neovim) 0.8.0+

[delta](https://github.com/yusukebe/gh-markdown-preview) 0.18.2+

[git](https://git-scm.com/) 2.0.0+

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'dpi0/ddf.nvim',
}
```


## Usage

Call the show diff function to launch a delta diff b/w the working tree and the staging area.

```lua
:lua require("ddf").show_diff()
```

Hit `q` to quit, `CTRL-D` and `CTRL-U` to scroll down/up.

## Configuration

### Options

```lua
opts = {
}
```

### Keybinds

```lua
keys = {
  {
    '<leader>gd',
    function()
      require('ddf').show_diff()
    end,
    desc = 'Git diff (delta) for current buffer',
  },
}
```

## Example Configuration for lazy.nvim

```lua
return {
  'dpi0/ddf.nvim',
  opts = {
  },
  keys = {
    {
      '<leader>gD',
      function()
        require('ddf').show_diff()
      end,
      desc = 'Git diff (delta) for current buffer',
    },
  },
}
```
