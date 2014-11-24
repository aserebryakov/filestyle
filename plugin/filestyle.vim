"Plugin checking the file to follow your Vim settings

if !exists("g:filestyle_plugin")
    let g:filestyle_plugin = 1
    highligh FileStyleError ctermbg=Red
endif

"Highlighting specified pattern
function FileStyleHighlightPattern(pattern)
    call matchadd('FileStyleError', a:pattern)
endfunction

"Checking file dependenly on settings
function FileStyleCheck()
    if &expandtab
        let l:filestyle_search_pattern = '\t\+'
    else
        let l:filestyle_search_pattern = '^\s\+'
    endif
    call FileStyleHighlightPattern(l:filestyle_search_pattern)
endfunction

