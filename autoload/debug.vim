" Public Functions {{{1

    fu! debug#prefix() " {{{2
        let l:debug_str = '[' . fnamemodify(bufname('%'), ':t') . ':'

        " Empty line
        if getline('.') =~# '^$'
            let l:debug_str .= line('.')
        else
            let l:debug_str .= string(str2nr(line('.')) + 1)
        endif

        let l:debug_str .= '] DBGSTR ==>'

        return l:debug_str
    endfu

    fu! debug#print(prefix, value, bang) " {{{2
        let l:prev_pos = getpos('.')
        let l:append_at_same_line = 0

        " Empty line
        if getline('.') =~# '^$'
            let l:append_at_same_line = 1
        endif

        if a:bang
            if exists('b:debug_print_pattern')
                put=printf(b:debug_print_pattern, a:prefix . ' ' . a:value)
            else
                echoerr 'No b:debug_print_pattern for filetype ' . &filetype
                return
            endif
        else
            if exists('b:debug_value_pattern')
                put=printf(b:debug_value_pattern, a:prefix . ' ' . a:value, a:value)
            else
                echoerr 'No b:debug_value_pattern for filetype ' . &filetype
                return
            endif
        endif

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
    endfu
