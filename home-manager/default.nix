{...}: {
  home.stateVersion = "24.05";
  imports = [
    #./hyprland.nix
    ./waybar.nix
    ./zsh.nix
  ];
}
