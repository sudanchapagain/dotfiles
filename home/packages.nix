{ pkgs, ... }:
{
  home.packages = with pkgs; [
    planify
    foliate
    ulauncher

    ffmpeg
    yt-dlp

    alacritty
    helix
    tmux
    git
    vscodium

    nixpkgs-fmt
    nixpkgs-lint
    nodejs
    odin
    rustup
    ols

    btop
    eza
    fzf
    ripgrep
    neofetch
    starship
    nushellFull
    busybox
  ];
}
