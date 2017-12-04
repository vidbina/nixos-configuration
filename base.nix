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
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
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
      displayManager = {
        slim = {
          enable = true;
          theme = pkgs.fetchurl {
            #url = "https://github.com/vidbina/asabina-slim-theme/archive/master.tar.gz";
            url = "https://github.com/vidbina/asabina-slim-theme/archive/132fa3339286681f636434333701330ef2c41104.tar.gz";
            #sha256 = "1d3e8fc41729b2ade2649d3083b7fddb81b3dde2ef6ecb95261ce32af5c9d2fdz";
            sha256 = "cfdc9cfcb4ea93b993caca3b82d16b55ed4b4f3207031b574dc5ced59dcc8cd0";
          };
        };
        sessionCommands = ''
          alias freeze="${pkgs.xtrlock-pam}/bin/xtrlock-pam -b none"
        '';
      };

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
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
}
