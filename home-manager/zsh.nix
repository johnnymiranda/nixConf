{
  pkgs,
  inputs,
  ...
}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history.path = "$HOME/.zhistory";
    history.save = 100000;
    history.size = 100000;
    history.share = true;
    history.extended = true;
    history.ignoreSpace = true;

    completionInit = ''
       autoload -Uz compinit
    '';

    shellAliases = {
      ls = "ls -h --color=auto --group-directories-first";
      n = "nvim";
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      TERM = "kitty";
      EDITOR = "nvim";
    };
  };
}
