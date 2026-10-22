dotfiles
========

my ~

Run `bash install.sh` to link the dotfiles into your home directory. Existing
files are preserved in the printed backup directory. The installer also backs up
a legacy `~/.git` symlink when it points to this repository's Git metadata, so
your home directory no longer acts as a Git working tree. Unrelated `~/.git`
files, directories, and symlinks are preserved.
