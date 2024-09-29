# Dotfiles

My dot files in one spot. Files here are symlinked to its proper place using GNU Stow.

## Usage

### Stow files

Symlink all files to their directory with:
```
make stow
```
Running `make stow` will execute a dry-run to show where all symlinks will go. You'll then be prompted to confirm whether you want to proceed with creating the symlinks.

You can remove all the symlinks with:
```
make stow-delete
```
Running `make stow-delete` will also require your confirmation to proceed with the operation.
