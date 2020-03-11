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

### Defaults

#### Commands

`vim-debug` provides the following commands:

| **Command** | **Description** |
|---|---|
| `:DebugPrint` | Format and put the string based on `g:DebugPrefix` and the passed argument. |
| `:DebugCounterReset` | Resets the value of `g:debug_counter` to 0. |

#### Mappings

No mappings are provided by default, see the _Setup_ section for some recommendations.

#### Filetypes

`FileType` autocommands are how you can add print statements, that needs to be formattable with Vim's `printf` function.

Rules:
- The pattern should contain two printf-formattable string markers.

The following are provided by default:

```
augroup debug
    au!

    au FileType awk     let b:debug_print_pattern = 'printf "%s\n", %s'
    au FileType c       let b:debug_print_pattern = 'printf("%s: %%d\n", %s);'
    au FileType python  let b:debug_print_pattern = 'print("%s", %s)'
    au FileType sh      let b:debug_print_pattern = 'printf ''%s\n'' %s'
    au FileType vim     let b:debug_print_pattern = 'echom printf("%s", %s)'
augroup END
```

#### Variables

For debugging breadcrumbs, the global `g:debug_counter` is provided, increment is as you see fit. This can be reset
with the `DebugCounterReset` command, or by your own means.

### Setup

Here is the setup that I use:

```
function! DebugIncrement()
    let g:debug_counter = g:debug_counter + 1

    return g:debug_counter
endfunction

function GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ''
    endif

    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]

    return join(lines, "\n")
endfunction

" Current visual selection
xnoremap <silent> <Leader>dv :<C-U>DebugPrint GetVisualSelection()<CR>

" Current word
nnoremap <silent> <Leader>dw :<C-U>DebugPrint expand('<cword>')<CR>

" Based on user input
nnoremap <silent> <Leader>dS :<C-U>DebugPrint input('Debug expression: ')<CR>

" Incremented number
nnoremap <silent> <Leader>di :<C-U>DebugPrint DebugIncrement()<CR>

" Reset incremented number
nnoremap <silent> <Leader>dr :<C-U>DebugCounterReset<CR>
```

### Additional Configuration

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
