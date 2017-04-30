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
    gpg
    i3status
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
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  networking = {
    hostName = "9350.bina.me";
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
    synaptics.enable = true;
#    libinput = {
#      clickMethod = "clickfinger";
#      scrollMethod = "twofinger"; # mimick Macbook behavior
#      sendEventsMode = "disabled"; # ingore if external pointing dev is connected
#      tapping = false; # mimick Macbook behavior
#      enable = true;
#    };
    videoDrivers = ["intel"];
    # NOTE: Set XMonad as wm again. Make sure to set .xmonad/xmonad.hs
    windowManager = {
      default = "i3";
      i3 = {
        enable = true;
      };
    };
    xkbOptions = "eurosign:e";
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  #

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = "/run/current-system/sw/bin/zsh";
    extraUsers.vid = {
      isNormalUser = true;
      # uid = 1988;
      description = "David Asabina";
      extraGroups = [ "wheel" "networkmanager" ];
      initialPassword = "#unsecure";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  virtualisation.docker.enable = true;
};
