{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelModules = [
      "af_packet" "vboxsf"
      "virtio" "virtio_pci" "virtio_ring" "virtio_net" "vboxguest"
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/nvme0n1";
    };
    initrd.luks.devices = [
      {
        name = "base.crypt.small";
        device = "/dev/nvme0n1p3"; # 100 GiB
        preLVM = true;
      }
      {
        name = "store";
        device = "/dev/nvme0n1p5"; # 300 GiB
        preLVM = true;
      }
    ];
  };

  fileSystems."/store" = {
    device = "/dev/mapper/store-store";
    fsType = "btrfs";
  };

#  fileSystems."/home" = {
#    device = "/dev/disk/by-label/store";
#    fsType = "btrfs";
#  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  };

  networking = {
    firewall.enable = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    networkmanager.enable = true;
    # wireless.enable = wlp58s0;  # Enables wireless support via wpa_supplicant.
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
    };
  };

  # List services that you want to enable:
  services = {
    acpid = {
      enable = true;
    };

    illum = {
      enable = true;
    };

    nixosManual.showManual = true;

    # Enable the OpenSSH daemon.
    # openssh.enable = true;

    # Enable CUPS to print documents.
    # printing.enable = true;


    # Enable the X11 windowing system.
    xserver = {
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
    # xserver.displayManager.sddm.enable = true;
    # xserver.desktopManager.plasma5.enable = true;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
}
