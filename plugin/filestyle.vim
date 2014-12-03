"   Copyright 2014 Alexander Serebryakov
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.

"Plugin checking the file to follow Your Vim settings

if !exists('g:filestyle_plugin')
  let g:filestyle_plugin = 1
  highligh FileStyleError ctermbg=Red guibg=Red

  "Defining auto commands
  augroup filestyle_auto_commands
    autocmd!
    autocmd BufReadPost,BufNewFile * call FileStyleActivate()
    autocmd FileType * call FileStyleCheckFiletype()
  augroup end

  "Defining plugin commands
  command! FileStyleActivate call FileStyleActivate()
  command! FileStyleDeactivate call FileStyleDeactivate()
  command! FileStyleCheck call FileStyleCheck()

endif


"Turn plugin on
function FileStyleActivate()
  let b:filestyle_active = 1
  call FileStyleCheck()
endfunction


"Turn plugin off
function FileStyleDeactivate()
  let b:filestyle_active = 0
  call clearmatches()
endfunction


"Check filetype to handle specific cases
function FileStyleCheckFiletype()
  "Avoid checking of help files
  if &filetype=='help'
    call FileStyleDeactivate()
  endif
endfunction


"Highlighting specified pattern
function FileStyleHighlightPattern(pattern)
  call matchadd('FileStyleError', a:pattern)
endfunction


"Checking expandtab option
function FileStyleExpandtabCheck()
  if &expandtab
    let l:search_pattern = '\t\+'
  else
    let l:search_pattern = '^\t* \+'
  endif
  call FileStyleHighlightPattern(l:search_pattern)
endfunction


"Checking trailing spaces
function FileStyleTrailingSpaces()
  call FileStyleHighlightPattern('\s\+$')
endfunction


"Checking long lines
function FileStyleLongLines()
  if &textwidth > 0
    let l:pattern = '\%' . (&textwidth+1) . 'v.*'
    call FileStyleHighlightPattern(l:pattern)
  endif
endfunction


"Checking file dependenly on settings
function FileStyleCheck()
  call clearmatches()
  call FileStyleExpandtabCheck()
  call FileStyleTrailingSpaces()
  call FileStyleLongLines()
endfunction

