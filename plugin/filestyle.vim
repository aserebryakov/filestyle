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

  highligh FileStyleTabsError ctermbg=Red guibg=Red
  highligh FileStyleTrailngSpacesError ctermbg=Cyan guibg=Cyan
  highligh FileStyleSpacesError ctermbg=Yellow guibg=Yellow
  highligh FileStyleTooLongLine cterm=inverse gui=inverse

  "Defining auto commands
  augroup filestyle_auto_commands
    autocmd!
    autocmd BufReadPost,BufNewFile * call FileStyleActivate()
    autocmd FileType * call FileStyleCheckFiletype()
    autocmd WinEnter * call FileStyleCheck()
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
function FileStyleHighlightPattern(highlight)
  call matchadd(a:highlight['highlight'], a:highlight['pattern'])
endfunction


"Checking expandtab option
function FileStyleExpandtabCheck()
  if &expandtab
    let l:highlight = {'highlight' : 'FileStyleTabsError',
                     \ 'pattern': '\t\+'}
  else
    let l:highlight = {'highlight' : 'FileStyleSpacesError',
                     \ 'pattern': '^\t* \+'}
  endif
  call FileStyleHighlightPattern(l:highlight)
endfunction


"Checking trailing spaces
function FileStyleTrailingSpaces()
    let l:highlight = {'highlight' : 'FileStyleTrailngSpacesError',
                     \ 'pattern': '\s\+$'}
  call FileStyleHighlightPattern(l:highlight)
endfunction


"Checking long lines
function FileStyleLongLines()
  if &textwidth > 0
    let l:highlight = {'highlight' : 'FileStyleTooLongLine',
                     \ 'pattern': '\%' . (&textwidth+1) . 'v.*' }
    call FileStyleHighlightPattern(l:highlight)
  endif
endfunction


"Checking file dependenly on settings
function FileStyleCheck()
  if b:filestyle_active == 1
    call clearmatches()
    call FileStyleExpandtabCheck()
    call FileStyleTrailingSpaces()
    call FileStyleLongLines()
  endif
endfunction

