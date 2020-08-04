" Verification {{{1

    if exists('g:_loaded_debug') || v:version < 802
        finish
    endif

    let g:_loaded_debug = 1

" Autocommands {{{1

    augroup debug
        au!

        au FileType awk     let b:debug_print_pattern = 'printf "%s\n"'
        au FileType awk     let b:debug_value_pattern = 'printf "%s %%s\n", %s'

        au FileType c       let b:debug_print_pattern = 'printf("%s\n");'
        au FileType c       let b:debug_value_pattern = 'printf("%s: %%s\n", %s);'

        au FileType python  let b:debug_print_pattern = 'print("%s")'
        au FileType python  let b:debug_value_pattern = 'print("%s", %s)'

        au FileType sh      let b:debug_print_pattern = 'printf ''%s\n'''
        au FileType sh      let b:debug_value_pattern = 'printf ''%s: %%s\n'' %s'

        au FileType vim     let b:debug_print_pattern = 'echom printf("%s")'
        au FileType vim     let b:debug_value_pattern = 'echom printf("%s: %%s", %s)'
    augroup END

" Variables {{{1

    " Breadcrumb debug printing
    let g:debug_counter = 0

" Commands {{{1

    command -bang -nargs=1 DebugPrint call debug#print(debug#prefix(), <args>, <bang>0)
    command DebugCounterReset let g:debug_counter = 0

