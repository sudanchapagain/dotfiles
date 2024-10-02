{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    git
    tmux
    helix
    starship
    neofetch
    vscodium
    ulauncher

    btop
    eza
    fzf
    ripgrep

    ffmpeg
    yt-dlp
    busybox

    nixpkgs-fmt
    nixpkgs-lint
    nodejs
    odin
    rustup
    ols
  ];
}
