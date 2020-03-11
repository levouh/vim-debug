" --- Verification

    if exists('g:_loaded_debug') || v:version < 802
        finish
    endif

    let g:_loaded_debug = 1

" --- Autocommands

    au FileType awk     let b:debug_print_pattern = 'printf "%s\n", %s'
    au FileType c       let b:debug_print_pattern = 'printf("%s: %%d\n", %s);'
    au FileType python  let b:debug_print_pattern = 'print("%s", %s)'
    au FileType sh      let b:debug_print_pattern = 'printf ''%s\n'' %s'
    au FileType vim     let b:debug_print_pattern = 'echom printf("%s", %s)'

" --- Variables

    " Breadcrumb debug printing
    let g:_debug_counter = 0

" --- Commands

    command -nargs=1 DebugPrint call debug#print(g:DebugPrefix(), <args>)

