# Arnaud Guignard's dotfiles

This repository started several years ago as a copy of the zsh file structure
from [Ryan Bates Dot Files](http://github.com/ryanb/dotfiles/tree/master).

## Installation

The installation script is written in Go. If Go isn't available there is still
the old Python `sync.py` script which should work.

The following instructions will clone the repository and install all files:

	git clone git://github.com/arno/dotfiles
	cd dotfiles
	go run sync.go -install

To add locally modified files to the repository or show differences between
locally installed files and the ones in the repository run the `sync.go` script
without the `-install` option:

	go run sync.go
