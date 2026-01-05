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
  keys = {
    {
      '<leader>gd',
      function()
        require('ddf').show_diff()
      end,
      desc = 'Git diff (delta) for current buffer',
    },
  },
}
```

## My `delta` Configuration

Present at `~/.config/git/config`

```text
# ...

[core]
  pager = delta
  editor = nvim
  autocrlf = false
  preloadindex = true # preloads the index into memory for improved performance when running Git commands like status and diff

[merge]
  conflictstyle = zdiff3 # https://www.ductile.systems/zdiff3/
  summary = true # display a brief summary describing what was merged

[interactive]
  diffFilter = delta --color-only

[delta]
  features = decorations
  line-numbers = true
  side-by-side = true
  true-color = always
  hyperlinks = true
  navigate = true  # use n and N to move between diff sections

[delta "interactive"]
  keep-plus-minus-markers = false

[delta "decorations"]
  commit-decoration-style = blue ol
  commit-style = raw
  file-style = omit
  hunk-header-decoration-style = blue box
  hunk-header-file-style = red
  hunk-header-line-number-style = "#067a00"
  hunk-header-style = file line-number syntax

# ...
```

## But Why When Fugitive's Diff Exists?

I used to use this keybind for Fugitive for the delta diffs

```lua
  {
    '<leader>gd',
    function()
      vim.cmd 'Git -c pager.diff=delta diff %'
      vim.cmd('resize ' .. math.floor(vim.o.lines * 0.9))
    end,
    desc = 'Fugitive: Git diff (delta, current file, 90% height)',
  },
```

But this behaved weirdly when using split buffers and I wanted something fullscreen at all times.
