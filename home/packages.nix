{ pkgs, ... }:
{
  home.packages = with pkgs; [
    foliate
    ulauncher

    ffmpeg
    yt-dlp

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
    busybox
  ];
}
