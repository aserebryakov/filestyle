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

1. If `expandtab` option is used, then all '\t' characters are highlighted,
   otherwise spaces in begining of the line are highlighted
2. Trailing spaces are highlighted

Commands:

  * `FileStyleActivate`   - enables plugin for current buffer
  * `FileStyleDeactivate` - disables plugin for current buffer
  * `FileStyleCheck`      - forcely checks current buffer


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
