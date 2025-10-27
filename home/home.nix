{
    lib,
    home-manager,
    config,
    pkgs,
    ...
}:

{
    home.username = "crimson";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    home.homeDirectory = "/home/crimson";

    home.file = {
        ".config/alacritty" = {
            source = ./alacritty;
            recursive = true;
        };
        ".config/git/config" = {
            source = ./git/gitconfig;
        };
        ".config/helix" = {
            source = ./helix;
            recursive = true;
        };
        ".config/nushell" = {
            source = ./nushell;
            recursive = true;
        };
        ".config/mpd/mpd.conf" = {
            source = ./mpd/mpd.conf;
        };
        ".config/zellij/config.kdl" = {
            source = ./zellij/config.kdl;
        };
    };
}
