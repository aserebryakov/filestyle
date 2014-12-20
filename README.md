filestyle
=========

Plugin checking text to correspond current Vim settings.

Installation
------------

Installation with Pathogen (recommended):

    $ cd ~/.vim/bundle
    $ git clone https://github.com/aserebryakov/filestyle.git

If you do not use Pathogen, clone repository and copy the content to
your '~/.vim/' directory.


Usage
-----

Plugin is loaded automatically and checks each opened file to correspond
Vim settings.

Current functionality:

1. If `expandtab` option is used, then all `\t` characters are highlighted (RED),
   otherwise spaces in begining of the line are highlighted (YELLOW)
2. Trailing spaces are highlighted (CYAN)
3. Line parts, that are longer than vaule of `textwidth` (if it was set)
   are highlighed (INVERT)
4. Control characters are highlighted (BLUE)

Commands:

  * `FileStyleActivate`   - enable plugin for current buffer
  * `FileStyleDeactivate` - disable plugin for current buffer
  * `FileStyleCheck`      - check current buffer

In order to configure file types to be ingored by a plugin, add the
following line to your `.vimrc` file:

    let g:filestyle_ignore = ['text']


Contribution
------------

Plugin source is available on GitHub by the link:

    https://github.com/aserebryakov/filestyle

If you want to improve this plugin, just fork the repository.


Changelog
---------

0.5.0 Implemented basic functionality:

* Highlighting of trailing spaces
* Highlighting of incorrect indentation

0.5.1

* Added commands to enable/disable plugin
* Several bug fixes
* Added separated highlighting for different cases

0.5.2

* Fixed the `undefined variable filestyle_active` error

0.6.0

* Configurable list of ignored file types
* Plugin turns off in all windows with current buffer opened
* Added highlighting of control characters

0.6.1

* Fixed compatibility with other plugins when Vundle is used
