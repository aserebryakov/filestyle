filestyle
=========

**filestyle** is a Vim plugin that highlights unwanted whitespace and
characters.

Highlights include:

* Trailing spaces
* Tabs or spaces depending on `'expandtab'`
* Lines longer than `'textwidth'`
* Control characters

**filestyle** also lets you fix these issues (experimental).

### Examples

![Example 1](https://cloud.githubusercontent.com/assets/985977/7272222/9809dbec-e8e9-11e4-8a43-47e0374ccbe0.png)

![Example 2](https://cloud.githubusercontent.com/assets/985977/7272223/980cb506-e8e9-11e4-8b3e-418506344c6b.png)

![Example 3](https://cloud.githubusercontent.com/assets/985977/7272224/98100864-e8e9-11e4-9e09-45b217125bcb.png)

Installation
------------

#### Step 1: Install filestyle

##### Pathogen

    $ cd ~/.vim/bundle
    $ git clone https://github.com/aserebryakov/filestyle.git

##### NeoBundle

    NeoBundle 'aserebryakov/filestyle'

##### Without plugin manager

Clone or download this repository and copy its contents to your `~/.vim/`
directory.

#### Step 2: Check your colorscheme (Vim only)

When using Vim (not gVim), make sure your colorscheme explicitly defines
`ctermbg` in a `Normal` highlight group as it is required for the ignore
patterns feature. For example:

    hi Normal ctermbg=15

Usage
-----

**filestyle** automatically checks each opened file.

##### Commands

* `:FileStyleEnable`     - enable plugin globally
* `:FileStyleDisable`    - disable plugin globally
* `:FileStyleActivate`   - enable plugin for current buffer
* `:FileStyleDeactivate` - disable plugin for current buffer
* `:FileStyleCheck`      - check current buffer
* `:FileStyleFix`        - fix style errors

##### Highlighting rules

1. If `'expandtab'` is set, highlight tabs (RED), if not, highlight spaces at
   the beginning of a line (YELLOW).
2. Highlight trailing spaces (CYAN)
3. Highlight line parts that exceed `'textwidth'` (INVERT)
4. Highlight control characters (BLUE)

##### FileStyleFix rules

1. Remove control characters
2. Remove trailing spaces
3. If `'expandtab'` is set, replace tabs with spaces, if not, replace spaces
   at the beginning of a line with tabs

##### Ignore file types

By default, **filestyle** checks all file types. To ignore a file type, for
example `text`, add the following line to your `.vimrc`:

    let g:filestyle_ignore = ['text']

##### Ignore patterns

**filestyle** allows you to specify patterns that should be ignored. To ignore
a pattern, for example quoted lines starting with `>`, add the following line
to your `.vimrc`:

    let g:filestyle_ignore_patterns = ['^\(> \?\)\+$']

##### Change highlight groups

**filestyle** currently uses these highlight groups:

    FileStyleTabsError
    FileStyleTrailingSpacesError
    FileStyleSpacesError
    FileStyleControlCharacter
    FileStyleTooLongLine
    FileStyleIgnoredPattern

Note that `FileStyleIgnoredPattern` is only used in gVim.

You can change a highlight group in your `.vimrc` or color scheme like this:

    highlight FileStyleTabsError ctermbg=3 guibg=Yellow

##### Known issues

* **filestyle** cannot detect `'textwidth'` changes. If you change `'textwidth'`,
  execute `:FileStyleCheck` to ensure the new width is used for highlighting long
  lines.

* Error E315 is be thrown by Vim in case of `'splitbelow'` option is set
  when `'help'` command is called

Contribution
------------

Source code and issues are hosted on GitHub:

    https://github.com/aserebryakov/filestyle

License
-------

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

Changelog
---------

#### 1.1.1

* Fixed cursor positioning after FileStyleFix call

#### 1.1.0

* Added support for user-defined highlight groups
* Fixed issue with tabs switching in INSERT mode

#### 1.0.0

* Implemented ignored patterns
* Removed highlighting of trailing spaces in current line when in Insert mode
* Improved order of highlights

#### 0.7.1

* Fixed issue with highlighting after colorscheme change

#### 0.7.0

* Implemented style errors fixing (experimental)
* Added commands to enable/disable filestyle globally
* Fixed highlighting of the EOL
* Fixed disabling filestyle for specific buffers

#### 0.6.1

* Fixed compatibility with other plugins when Vundle is used

#### 0.6.0

* Added option to ignore certain file types
* Changed `:FileStyleDeactivate` to turn off highlighting in all windows of the
  current buffer
* Added highlighting of control characters

#### 0.5.2

* Fixed the `undefined variable filestyle_active` error

#### 0.5.1

* Added commands to enable/disable filestyle
* Fixed several bugs
* Changed highlighting to use distinct colors for different violations of
  buffer settings

#### 0.5.0

* Added highlighting of trailing spaces
* Added highlighting of incorrect indentation

Credits
-------

* Alexander Serebryakov, original author ([GitHub](https://github.com/aserebryakov))
* Markus Weimar ([GitHub](https://github.com/Markus00000))
