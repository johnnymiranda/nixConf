{...}: {
  programs.git = {
    enable = true;
    userName = "Johnathan Miranda";
    userEmail = "john@cryptex-labs.com";
    extraConfig = {
      init.defaultBranch = "main";
      color = {
        ui = "auto";
      };
      push = {
        default = simple";
      };
    };
  };
}
