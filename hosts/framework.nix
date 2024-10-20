{ 
  lib, 
  config, 
  pkgs, 
  inputs, 
  ... 
}: {
  imports = [
    ../modules
    #inputs.sops-nix.nixosModules.sops
  ];
  programs.zsh.enable = true;
  hyprland.enable = true;

  users.defaultUserShell = pkgs.zsh;
  
  home-manager.backupFileExtension = "backup";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking - 
  # TODO: Figure out wireless with sops
  networking.hostName = "framework"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.bluetooth.enable = true; 

  users.users.john = {
    isNormalUser = true;
    description = "john";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  services.getty.autologinUser = "john";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    zsh
    kitty
    tmux
    ripgrep
    neofetch
    curl
    wget
    bat
    unzip
    fzf
    htop
    btop
    ripgrep
    fd
    jq
    tree
    file
    lolcat
    openssh
  ];
 
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
  };

  # fonts 
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ]; 
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ]; 

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/00429430-27d0-4396-8c52-ac330fb7fca5";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EFAF-3EB9";
    fsType = "vfat";
    options = [ "fmask=077" "dmask=0077" ];
  };

  swapDevices = [ ]; 

  networking.useDHCP = lib.mkDefault true;
  
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
