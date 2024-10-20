{...}: {
  home.stateVersion = "24.05";
  imports = [
    #./hyprland.nix
    ./zsh.nix
  ];
}
