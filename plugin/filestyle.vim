"Plugin checking the file to follow Your Vim settings

if !exists("g:filestyle_plugin")
    let g:filestyle_plugin = 1
    highligh FileStyleError ctermbg=Red

    "Defining autocommands
    augroup FileStyleAutoCommands
        autocmd!
        autocmd BufReadPost * call FileStyleCheck()
    augroup end
endif


"Highlighting specified pattern
function FileStyleHighlightPattern(pattern)
    if !exists("b:filestyle_match")
        let b:filestyle_match = 0
    else
        call matchdelete(b:filestyle_match)
    endif

    let b:filestyle_match = matchadd('FileStyleError', a:pattern)
endfunction


"Checking expandtab option
function FileStyleExpandtabCheck()
    if &expandtab
        let l:filestyle_search_pattern = '\t\+'
    else
        let l:filestyle_search_pattern = '^ \+'
    endif
    call FileStyleHighlightPattern(l:filestyle_search_pattern)
endfunction


"Checking trailing spaces
function FileStyleTrailingSpaces()
    call FileStyleHighlightPattern('\s\+$')
endfunction


"Checking file dependenly on settings
function FileStyleCheck()
    call FileStyleExpandtabCheck()
    call FileStyleTrailingSpaces()
endfunction

