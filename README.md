*<h1 align="center">dotfiles</h1>*

**personal** dotfiles repository for nix-os and windows cli programs. managed with GNU stow in linux.

> [!WARNING]  
> config might not work on your system as it doesn't even work as i want in mine. mostly cause programs like alacritty have conflicting config in both alacritty's config and home-manager config. so, it's probably best not to copy it over. also, i've decided i won't be doing any more tweaks or additions to hyprland. it has become a bit too much for me to handle all the small stuff.

trying to keep all config/changes clean, simple, & minimal as much as possible to be closer to original/bare program currently using the followings:

| tool              | desc                                                                      |
| ----------------- | ------------------------------------------------------------------------- |
| Alacritty         | rosepine colorscheme & minor changes config.                              |
| Tmux              | still learning                                                            |
| btop              | rosepine colorscheme                                                      |
| starship          | nothing special                                                           |
| Neovim            | plugins includes lazy package manager, mason, telescope, harpoon and etc. |
| VSCode            | vscodium with VIM motions, clang formatter instead GCC.                   |
| Hyprland & family | simple config with hyprlock, hypridle, hyprpaper. Minimal waybar and wofi.|

> [!NOTE]
> **FOR ME**
> - rewrite configs of applications/tools to nix after flake based system config is completed.
> - fix and add hyprland and et. config. basic things aren't working.
