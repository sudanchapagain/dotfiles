<h1 align="center"><i>dotfiles</i></h1>

**personal** dotfiles repository for nix-os and windows cli programs. managed with GNU
stow in linux.

> [!WARNING]  
> config might not work on your system as something have conflicting configuration like
> alacritty has config in both `~/.config/alacritty` and home-manager's config & the
> hyprland setup isn't complete.

trying to keep all config/changes simple & minimal as much as possible to be closer to
original/bare program currently using GNOME with few extensions as desktop environment,
a incomplete hyprland setup also exists and might switch to it after fixing all the
minor things, alacritty as terminal emulator with tmux for multiplexing & starship as
prompt, neovim as text editor, vscodium still as primary code editor with VIM motions,

## things to do (to-do)
```diff
- 1. switch whole system config to flake
- 2. .bashrc isn't being used (could be nix home-manager coflict, or symbolic link)
3. starship doesn't work inside tmux (probably is because of 2. )
+ 4. switch simple configs like .gitconfig, btop, neofetch, alacritty to home-manager
````
