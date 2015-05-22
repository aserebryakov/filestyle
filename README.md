filestyle
=========

**filestyle** is a Vim plugin that highlights whitespace that violates your
buffer settings. This includes:

* Trailing spaces
* Tabs or spaces depending on `|expandtab|`
* Lines longer than `|textwidth|`
* Control characters

**filestyle** also lets you fix these violations (experimental).

### Examples

![Example 1](https://cloud.githubusercontent.com/assets/985977/7272222/9809dbec-e8e9-11e4-8a43-47e0374ccbe0.png)

![Example 2](https://cloud.githubusercontent.com/assets/985977/7272223/980cb506-e8e9-11e4-8b3e-418506344c6b.png)

![Example 3](https://cloud.githubusercontent.com/assets/985977/7272224/98100864-e8e9-11e4-9e09-45b217125bcb.png)

Installation
------------

#### Step 1: Install the plugin

##### Pathogen

    $ cd ~/.vim/bundle $ git clone https://github.com/aserebryakov/filestyle.git

##### NeoBundle

    NeoBundle 'aserebryakov/filestyle'

##### Without plugin manager

Clone this repository and copy the content to your `~/.vim/` directory.

#### Step 2: Check your colorscheme (Vim only)

When using Vim (not gVim), make sure your colorscheme explicitly defines
`ctermbg` in a `Normal` highlight group as it is required for the ignore
patterns feature. For example:

    hi Normal ctermbg=15

Usage
-----

**filestyle** automatically checks each opened file.

##### Commands

  * `FileStyleEnable`     - enable plugin globally
  * `FileStyleDisable`    - disable plugin globally
  * `FileStyleActivate`   - enable plugin for current buffer
  * `FileStyleDeactivate` - disable plugin for current buffer
  * `FileStyleCheck`      - check current buffer
  * `FileStyleFix`        - fix style errors

##### Highlighting rules

1. If `|expandtab|` is set, highlight tabs (RED), if not, highlight spaces at
   the beginning of a line (YELLOW).
1. Highlight trailing spaces (CYAN)
1. Highlight line parts that exceed `|textwidth|` (INVERT)
1. Highlight control characters (BLUE)

##### FileStyleFix rules

1. Remove control characters
1. Remove trailing spaces
1. If `|expandtab|` is set, replace tabs with spaces, if not, replace spaces at
the beginning of a line with tabs

##### Ignore file types

By default, **filestyle** checks all file types. To ignore a file type, for
example `text`, add the following line to your `.vimrc`:

    let g:filestyle_ignore = ['text']

##### Ignore patterns

**filestyle** allows you to specify patterns that should be ignored. To ignore a
pattern, for example quoted lines starting with `>`, add the following line to
your `.vimrc`:

    let g:filestyle_ignore_patterns = ['^\(> \?\)\+$']

Contribution
------------

Source code and issues of the plugin are hosted on GitHub:

    https://github.com/aserebryakov/filestyle

##### Contributors

* Alexander Serebryako
 ([GitHub](https://github.com/aserebryakov/),
 [Stack Overflow](http://stackoverflow.com/users/1132871/alex))
* Markus Weimar
 ([GitHub](https://github.com/Markus00000),
 [Web](http://www.markusweimar.de/en/))

Changelog
---------

#### 1.0.0

* Implemented ignored patterns
* Removed highlighting of trailing spaces in current line when in Insert mode
* Improved order of highlights

#### 0.7.1

* Fixed issue with highlighting after colorscheme change

#### 0.7.0

* Implemented style errors fixing (experimental)
* Added commands to enable/disable the plugin globally
* Fixed highlighting of the EOL
* Fixed disabling the plugin for specific buffers

#### 0.6.1

* Fixed compatibility with other plugins when Vundle is used

#### 0.6.0

* Added option to ignore certain file types
* Changed `FileStyleDeactivate` to turn off highlighting in all windows of the
  current buffer
* Added highlighting of control characters

#### 0.5.2

* Fixed the `undefined variable filestyle_active` error

#### 0.5.1

* Added commands to enable/disable the plugin
* Fixed several bugs
* Changed highlighting to use distinct colors for different violations of
  buffer settings

#### 0.5.0

* Added highlighting of trailing spaces
* Added highlighting of incorrect indentation
