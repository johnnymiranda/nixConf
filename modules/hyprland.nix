{ 
  lib, 
  config, 
  pkgs, 
  ... 
}: {
  options.hyprland.enable = lib.mkEnableOption "Enable hyprland";

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  
   services.greetd = {
     enable = true;
     settings = {
       default_session = {
         command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
         user = "greeter";
       };
     };
   };
   
    users.users.john = {
      packages = with pkgs; [
        hyprpaper
        hyprshot
        hypridle
        rofi-wayland
        waybar
        gnome-icon-theme
        swaynotificationcenter
      ];
    };
  };
} 
