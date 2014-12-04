filestyle
=========

Plugin checking text to correspond current Vim settings.

Installation
------------

If you use Pathogen (recommended) just clone the repository:
>https://github.com/aserebryakov/filestyle

to your `<vim_files_path>/bundle/` directory.
Otherwise, you need to copy files to your `<vim_files_path>` directory.


Usage
-----

There are no specific usage instructions. Plugin is loaded automatically
and checks each opened file to correspond Vim settings.

Current functionality:

1. If `expandtab` option is used, then all `\t` characters are highlighted,
   otherwise spaces in begining of the line are highlighted
2. Traling spaces are highlighted
3. Line parts, that are longer than vaule of |textwidth| (if it was set)
   are highlighed


Contribution
------------

Plugin source is available on GitHub by the link:

>https://github.com/aserebryakov/filestyle

If you want to improve this plugin, just fork the repository.

Changelog
---------

0.5.0 Implemented basic functionality:

- highlighting of trailing spaces
- highlighting of incorrect indentation

