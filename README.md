## vim-debug

_Define debug print statements based on filetype._

### Note

I have no idea what I am doing, so if you find a problem with this plugin please let me know.

### Support

_I have only tested this plugin with the following:_  
- _Vim_: 8.2.227  
- _OS_: Linux

### Installation

```
Plug 'levouh/vim-debug'
```

### Setup

`vim-debug` provides the following commands:

| **Command** | **Description** |
|---|---|
| `:DebugPrint` | Format and put the string based on `g:DebugPrefix` and the passed argument. |

No mappings are provided by default, but some example mappings might include:

```
TODO
```

### Configuration

You can change the prefix string used by defining `g:DebugPrefix`, the default implementation is:

```
function! g:DebugPrefix()
    let l:debug_str = '[' . fnamemodify(bufname('%'), ':t') . ':'

    " Empty line
    if getline('.') =~# '^$'
        let l:debug_str .= line('.')
    else
        let l:debug_str .= string(str2nr(line('.')) + 1)
    endif

    let l:debug_str .= '] DBGSTR ==> '

    return l:debug_str
endfunction
```

### Mentions

- Functionality/ideas have been borrowed from [vim-debugstring](https://github.com/bergercookie/vim-debugstring) and [vim-printf](https://https://github.com/mptre/vim-printf)
