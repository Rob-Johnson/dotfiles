#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fixture="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-install.XXXXXX")"
# Keep the fixture for inspection; no user files are modified.
printf 'Installer fixture: %s\n' "$fixture"
mkdir -p "$fixture/home/dotfiles" "$fixture/outside"
cp "$repo_dir/install.sh" "$fixture/home/dotfiles/install.sh"
printf 'fixture shell config\n' >"$fixture/home/dotfiles/.bashrc"
git init -q "$fixture/home/dotfiles"
ln -s "$fixture/home/dotfiles/.git" "$fixture/home/.git"
HOME="$fixture/home" bash "$fixture/home/dotfiles/install.sh" >/dev/null
if [[ -e "$fixture/home/.git" || -L "$fixture/home/.git" ]]; then
    echo 'FAIL: installer left the legacy home Git link in place' >&2
    exit 1
fi
[[ -d "$fixture/home/dotfiles/.git" ]]
git -C "$fixture/home/dotfiles" rev-parse --git-dir >/dev/null
if git -C "$fixture/home" rev-parse --show-toplevel >/dev/null 2>&1; then
    echo 'FAIL: home is still a Git working tree' >&2
    exit 1
fi
backup=$(find "$fixture/home" -maxdepth 2 -type l -name .git -print)
[[ -n "$backup" && "$backup" -ef "$fixture/home/dotfiles/.git" ]]

# Unrelated repositories, including symlinks, must survive installation.
for kind in directory unrelated-link unrelated-file dangling-link; do
    home_dir="$fixture/$kind"
    mkdir -p "$home_dir"
    if [[ "$kind" == directory ]]; then
        git init -q "$home_dir"
    elif [[ "$kind" == unrelated-link ]]; then
        git init -q "$fixture/outside"
        ln -s "$fixture/outside/.git" "$home_dir/.git"
    elif [[ "$kind" == unrelated-file ]]; then
        printf 'gitdir: /unrelated/repository\n' >"$home_dir/.git"
    else
        ln -s "$fixture/missing/.git" "$home_dir/.git"
    fi
    HOME="$home_dir" bash "$fixture/home/dotfiles/install.sh" >/dev/null
    [[ -e "$home_dir/.git" || -L "$home_dir/.git" ]]
done
# Relative symlinks must migrate too.
mkdir -p "$fixture/relative-home"
ln -s '../home/dotfiles/.git' "$fixture/relative-home/.git"
HOME="$fixture/relative-home" bash "$fixture/home/dotfiles/install.sh" >/dev/null
[[ ! -e "$fixture/relative-home/.git" && ! -L "$fixture/relative-home/.git" ]]

# A worktree's .git metadata file must never be linked into HOME.
mkdir -p "$fixture/worktree" "$fixture/worktree-home"
cp "$repo_dir/install.sh" "$fixture/worktree/install.sh"
printf 'gitdir: /unrelated/worktree-metadata\n' >"$fixture/worktree/.git"
HOME="$fixture/worktree-home" bash "$fixture/worktree/install.sh" >/dev/null
[[ ! -e "$fixture/worktree-home/.git" && ! -L "$fixture/worktree-home/.git" ]]
[[ -f "$fixture/worktree/.git" ]]
echo 'PASS: legacy home Git link migration and unrelated repository preservation'
