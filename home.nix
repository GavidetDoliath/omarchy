{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
    stateVersion = "24.11";
  };

  # Import all modules
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/terminal.nix
    ./modules/fonts.nix
    ./modules/themes.nix
    ./modules/keybindings.nix
    ./modules/packages.nix
  ];

  programs.home-manager.enable = true;
}
