" --- Global Functions

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

" --- Public Functions

    function! debug#print(prefix, value)
        if !exists('b:debug_print_pattern')
            echoerr 'No print pattern found for filetype: ' . &filetype
            return
        endif

        let l:prev_pos = getpos('.')
        let l:append_at_same_line = 0

        " Empty line
        if getline('.') =~# '^$'
            let l:append_at_same_line = 1
        endif

        put=printf(b:debug_print_pattern, a:prefix . ' ' . a:value, a:value)

        " Correct indentation level
        if indent(line('.') - 1) !=# 0
            normal! k0vwhyjP
        endif

        normal! ==

        let l:new_pos = l:prev_pos

        if l:append_at_same_line
            " Move them to previous line
            normal! kJ
        else
             " Go directly to the next line
            let l:new_pos[1] += 1
        endif

        call setpos('.', l:new_pos)
    endfunction
