#!/bin/bash

# Dotfiles installation script
# Creates symlinks from home directory to dotfiles in this repo

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "Backup directory created: $BACKUP_DIR"

# Function to backup and symlink a file
link_file() {
    local src="$1"
    local dst="$2"
    
    if [[ -e "$dst" || -L "$dst" ]]; then
        echo "Backing up existing $dst"
        mv "$dst" "$BACKUP_DIR/"
    fi
    
    echo "Linking $src -> $dst"
    ln -sf "$src" "$dst"
}

# Link dotfiles (files starting with .)
for file in "$DOTFILES_DIR"/.*; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        # Skip .git, .DS_Store, and .gitignore/gitmodules
        if [[ "$filename" != ".git" && "$filename" != ".DS_Store" && "$filename" != ".gitignore" && "$filename" != ".gitmodules" ]]; then
            link_file "$file" "$HOME/$filename"
        fi
    fi
done

# Link .zsh files to home directory
for file in "$DOTFILES_DIR"/*.zsh; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        link_file "$file" "$HOME/.$filename"
    fi
done

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Link ghostty config
if [[ -f "$DOTFILES_DIR/ghostty-config" ]]; then
    mkdir -p "$HOME/.config/ghostty"
    link_file "$DOTFILES_DIR/ghostty-config" "$HOME/.config/ghostty/config"
fi

# Link .vim directory if it exists
if [[ -d "$DOTFILES_DIR/.vim" ]]; then
    link_file "$DOTFILES_DIR/.vim" "$HOME/.vim"
fi

# Link .config directory contents if it exists
if [[ -d "$DOTFILES_DIR/.config" ]]; then
    for item in "$DOTFILES_DIR/.config"/*; do
        if [[ -e "$item" && "$(basename "$item")" != ".DS_Store" ]]; then
            mkdir -p "$HOME/.config"
            link_file "$item" "$HOME/.config/$(basename "$item")"
        fi
    done
fi

# Link bin directory
if [[ -d "$DOTFILES_DIR/bin" ]]; then
    mkdir -p "$HOME/bin"
    for script in "$DOTFILES_DIR/bin"/*; do
        if [[ -f "$script" ]]; then
            link_file "$script" "$HOME/bin/$(basename "$script")"
        fi
    done
fi

echo ""
echo "Dotfiles installation complete!"
echo "Backup created in: $BACKUP_DIR"
echo "Run 'source ~/.zshrc' or start a new shell to apply changes."