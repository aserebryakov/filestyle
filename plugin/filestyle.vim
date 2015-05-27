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


"Create ignored pattern highlight group
function! FileStyleCreateIgnoredPatternGroup()
  let l:colors = ''

  redir => l:colors
  silent highlight
  redir END

  let l:normal_start = match(l:colors, 'Normal\s\+xxx')

  "Normal highlight group should be defined explicitly
  if (l:normal_start == -1)
    echom 'FileStyle: Normal highlight group is not found'
    return
  endif

  let l:normal_end = match(l:colors, '\n', l:normal_start)
  let l:normal_group = l:colors[(l:normal_start):(l:normal_end)]

  if (match(l:normal_group, 'ctermbg=') == -1)
    echom 'FileStyle: ctermbg parameter should be defined explicitly'
    return
  endif

  let l:ignored_group = substitute(l:normal_group,
                                 \ 'Normal\s\+xxx',
                                 \ 'highlight FileStyleIgnoredPattern',
                                 \ '')
  execute l:ignored_group
endfunction!


"Create highlight groups
function! FileStyleCreateHighlightGroups()
  highlight FileStyleTabsError ctermbg=Red guibg=Red
  highlight FileStyleTrailingSpacesError ctermbg=Cyan guibg=Cyan
  highlight FileStyleSpacesError ctermbg=Yellow guibg=Yellow
  highlight FileStyleControlCharacter ctermbg=Blue guibg=Blue
  highlight FileStyleTooLongLine cterm=inverse gui=inverse

  if has('gui_running')
    highlight FileStyleIgnoredPattern guibg=bg gui=NONE
  else
    call FileStyleCreateIgnoredPatternGroup()
  endif

endfunction!


"Turn plugin on for a current buffer
function! FileStyleActivate()
  let b:filestyle_active = 1
  call FileStyleCheckFiletype()
  call FileStyleCheck()
endfunction!


"Turn plugin off for a current buffer
function! FileStyleDeactivate()
  let b:filestyle_active = 0
  let l:filename = expand('%:p')
  windo call FileStyleClearFile(l:filename)

  "Moving to the first window after windo
  wincmd w
endfunction!


"Clear matches if name of the file is the same as given
function! FileStyleClearFile(filename)
  if a:filename == expand('%:p')
    call clearmatches()
  endif
endfunction!


"Check filetype to handle specific cases
function! FileStyleCheckFiletype()
  "Disable checking of the files in black list
  if index(g:filestyle_ignore, &filetype) != -1
    call FileStyleDeactivate()
  endif
endfunction!


"Highlighting specified pattern
function! FileStyleHighlightPattern(highlight)
  if has_key(a:highlight, 'priority')
      let l:priority = a:highlight['priority']
  else
      let l:priority = g:filestyle_default_match_priority
  endif

  call matchadd(a:highlight['highlight'],
              \ a:highlight['pattern'],
              \ l:priority)
endfunction!


"Checking expandtab option
function! FileStyleExpandtabCheck()
  if &expandtab
    let l:highlight = {'highlight' : 'FileStyleTabsError',
                     \ 'pattern': '\t\+'}
  else
    let l:highlight = {'highlight' : 'FileStyleSpacesError',
                     \ 'pattern' : '^\t* \+'}
  endif
  call FileStyleHighlightPattern(l:highlight)
endfunction!


"Checking trailing spaces
function! FileStyleTrailingSpaces()
    let l:highlight = {'highlight' : 'FileStyleTrailingSpacesError',
                     \ 'pattern': '\s\+$'}
  call FileStyleHighlightPattern(l:highlight)
endfunction!


"Checking long lines
function! FileStyleLongLines()
  if &textwidth > 0
    let l:highlight = {'highlight' : 'FileStyleTooLongLine',
                     \ 'pattern': '\%>' . &textwidth . 'v.\+' }
    call FileStyleHighlightPattern(l:highlight)
  endif
endfunction!


"Checking control characters
function! FileStyleControlCharacters()
  let l:highlight = {'highlight' : 'FileStyleControlCharacter',
                   \ 'pattern': '[\x00-\x08\x0a-\x1f]'}
  call FileStyleHighlightPattern(l:highlight)
endfunction!


"Clearing ignored patterns
function! FileStyleClearIgnoredPatters()
  if exists('g:filestyle_ignore_patterns')
      for pattern in g:filestyle_ignore_patterns
          let l:highlight = {'highlight' : 'FileStyleIgnoredPattern',
                           \ 'pattern': pattern,
                           \ 'priority': 10}
          call FileStyleHighlightPattern(l:highlight)
      endfor
  endif
endfunction!


"Sets the trailing spaces to be ignored in InsertMode
function! FileStyleInsertModeEnter()

  "Autocommands handling cursor moving
  augroup filestyle_auto_commands_insert_mode
    autocmd!
    autocmd CursorMovedI * call FileStyleIgnoreTrailingSpaces()
  augroup end

  call FileStyleIgnoreTrailingSpacesInCurrentLine()
endfunction!


"Sets the trailing spaces not to be ignored
function! FileStyleInsertModeLeave()

  "Clean autocommands before leaving InsertMode
  augroup filestyle_auto_commands_insert_mode
    autocmd!
  augroup end

  "Cleaning up variables
  call FileStyleNotIgnoreTrailingSpaces()
  unlet g:filestyle_current_line
  unlet g:filestyle_current_line_match

endfunction!


"Sets the trailing spaces to be ignored in a current line
function! FileStyleIgnoreTrailingSpacesInCurrentLine()
    let g:filestyle_current_line = line('.')
    let g:filestyle_current_line_match =  matchadd(
        \ 'FileStyleIgnoredPattern',
        \ '\%' . g:filestyle_current_line . 'l\s\+$',
        \ 10)
endfunction!


"Removes ignoring trailing spaces from matches list
function! FileStyleNotIgnoreTrailingSpaces()
  if exists('g:filestyle_current_line_match')
    call matchdelete(g:filestyle_current_line_match)
  endif
endfunction!


"Sets trailing spaces to be ignored
function! FileStyleIgnoreTrailingSpaces()
  if exists('g:filestyle_current_line')
    if(g:filestyle_current_line != line('.'))
      call FileStyleNotIgnoreTrailingSpaces()
      call FileStyleIgnoreTrailingSpacesInCurrentLine()
    else
      return
    endif
  else
      call FileStyleIgnoreTrailingSpacesInCurrentLine()
  endif
endfunction!


"Checking file dependenly on settings
function! FileStyleCheck()
  if get(g:, 'filestyle_enabled', 0) == 0
    return
  endif

  if get(b:, 'filestyle_active', 0) == 0
    return
  endif

  call clearmatches()
  call FileStyleTrailingSpaces()
  call FileStyleExpandtabCheck()
  call FileStyleControlCharacters()
  call FileStyleLongLines()
  call FileStyleClearIgnoredPatters()
endfunction!


"Remove trailing spaces
function! FileStyleTrailngSpacesFix()
  silent! execute '%s/\s\+$//'
endfunction!


"Function iterating over entire buffer and processing each
"line with a given function
function! FileStyleDoForEachLine(function)
  for l:i in range(line('$'))
    let l:line = getline(l:i)
    let l:result_line = call(a:function, [l:line])
    call setline(l:i, l:result_line)
  endfor
endfunction!


"Function replacing spaces with tabs
function! FileStyleFixIndent(line)
  let l:indent_len = 0
  for l:i in range(strlen(a:line))
    if a:line[l:i] == " "
      let l:indent_len += 1
    elseif a:line[l:i] == "\t"
      let l:indent_len = (l:indent_len/&tabstop + 1)*&tabstop
    else
      break
    endif
  endfor

  let l:indent_tabs = l:indent_len/&tabstop
  let l:indent_string = ""

  for l:i in range(l:indent_tabs)
    let l:indent_string .= "\t"
  endfor

  return (l:indent_string . substitute(a:line, '^\s\+', '', ''))
endfunction!


"Fix indentations
function! FileStyleExpandtabFix()
  if &expandtab
    %retab
  else
    "Command retab! is not used because it may replace
    "correct spaces with tabs
    call FileStyleDoForEachLine('FileStyleFixIndent')
  endif
endfunction!


"Remove control characters
function! FileStyleControlCharactersFix()
  silent! execute '%s/[\x00-\x08\x0a-\x1f]//g'
endfunction!


"Fix filestyle errors
function! FileStyleFix()
  call FileStyleControlCharactersFix()
  call FileStyleTrailngSpacesFix()
  call FileStyleExpandtabFix()
endfunction!


"Enable plugin globally
function! FileStyleEnable()
  let g:filestyle_enabled = 1
  windo call FileStyleActivate()
  wincmd w
endfunction!


"Disable plugin globally
function! FileStyleDisable()
  let g:filestyle_enabled = 0
  windo call clearmatches()
  wincmd w
endfunction!


"Plugin startup code
if !exists('g:filestyle_plugin')
  let g:filestyle_plugin = 1
  let g:filestyle_enabled = 1
  let g:filestyle_default_match_priority = 1
  let g:filestyle_ignore_default = ['help', 'nerdtree']

  if !exists('g:filestyle_ignore')
    let g:filestyle_ignore = g:filestyle_ignore_default
  else
    let g:filestyle_ignore += g:filestyle_ignore_default
  endif

  call FileStyleCreateHighlightGroups()

  "Defining auto commands
  augroup filestyle_auto_commands
    autocmd!
    autocmd BufReadPost,VimEnter,FileType * call FileStyleActivate()
    autocmd WinEnter * call FileStyleCheck()
    autocmd ColorScheme * call FileStyleCreateHighlightGroups()
    autocmd InsertEnter * call FileStyleInsertModeEnter()
    autocmd InsertLeave * call FileStyleInsertModeLeave()
  augroup end

  "Defining plugin commands
  command! FileStyleEnable call FileStyleEnable()
  command! FileStyleDisable call FileStyleDisable()
  command! FileStyleActivate call FileStyleActivate()
  command! FileStyleDeactivate call FileStyleDeactivate()
  command! FileStyleCheck call FileStyleCheck()
  command! FileStyleFix call FileStyleFix()

endif
