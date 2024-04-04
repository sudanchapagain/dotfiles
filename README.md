<div align="center">
# *dotfiles*
</div>

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

> [!TODO]
> - switch whole system config to flake
> - starship doesn't work inside tmux
> - .bashrc isn't being used (could be nix home-manager coflict, or symbolic link)
> - switch simple configs like .gitconfig, btop, neofetch, alacritty to home-manager
> - make tmux, hypr better