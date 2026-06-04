{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # System utilities
    git
    curl
    wget
    htop
    btop
    neofetch
    ripgrep
    fd
    fzf
    bat
    eza
    zoxide
    tldr

    # Applications
    firefox
    nautilus
    spotify
    vscodium

    # Development
    nodejs
    python3
    lua
    go
    rust

    # Terminal multiplexer & shell
    tmux
    zsh
    fish

    # Display server
    wayland
    wl-clipboard
    wl-paste

    # Screenshot & screen recording
    grim
    slurp
    swww
    ffmpeg

    # System
    systemd
    upower
    brightnessctl

    # Network
    networkmanager
    bluez
    pulseaudio

    # Fonts
    liberation_ttf

    # Misc
    xdg-utils
    notify-desktop
  ];
}
