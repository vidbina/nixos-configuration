{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    curl
    dmenu
    git
    gnupg
    rxvt_unicode
    st
    vim
    torbrowser
    wget
  ];

  fileSystems."/home" = {
    device = "/dev/disk/by-label/store";
    fsType = "btrfs";
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  };

  networking = {
  # networking.wireless.enable = wlp58s0;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableSyntaxHighlighting = true;

  services.illum = {
    enable = true;
  };

  services.nixosManual.showManual = true;

  # Enable the X11 windowing system.
  services.xserver = {
    autorun = true;
    # dpi = 180;
    enable = true;
    exportConfiguration = true;
    layout = "us";
    # 846x476 mllimeters reported by Dell XPS 13
    # $ nix-shell -p xorg.xdpyinfo
    # $ xdpyinfo | grep -B2 resolution
    monitorSection = ''
      DisplaySize 423 238
    '';
    videoDrivers = ["intel"];
    # NOTE: Set XMonad as wm again. Make sure to set .xmonad/xmonad.hs
    xkbOptions = "eurosign:e";
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  #

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  virtualisation.docker.enable = true;
}
