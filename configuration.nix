# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    vim
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

  services.nixosManual.showManual = true;

  # Enable the X11 windowing system.
  services.xserver = {
    autorun = false;
    desktopManager = {
      kde4 = {
        enable = true;
      };
    };
    displayManager = {
      # https://nixos.org/wiki/Using_X_without_a_Display_Manager
      lightdm = {
        enable = true;
      };
    };
    enable = true;
    layout = "us";
    synaptic = {
      enable = true;
    };
    videoDrivers = ["intel"];
    windowManager = {
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
  users.extraUsers.vid = {
    isNormalUser = true;
    # uid = 1988;
    description = "David Asabina";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "#unsecure";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  virtualisation.docker.enable = true;

}
