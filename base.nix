{ config, pkgs, ... }:

let
  lowBatteryNotifier = pkgs.writeScript "lowBatteryNotifier"
  ''
      BAT_PCT=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '[0-9]+(?=%)'`
      BAT_STA=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '\w+(?=,)'`
      echo "Checking battery level"
      test $BAT_PCT -le 10 && test $BAT_PCT -gt 5 && test $BAT_STA = "Discharging" && DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send -c device -u normal   "Low Battery" "Would be wise to keep my charger nearby."
      test $BAT_PCT -le  5                        && test $BAT_STA = "Discharging" && DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send -c device -u critical "Low Battery" "Charge me or watch me die!"
  '';
in {
  # Use the systemd-boot EFI boot loader.
  boot = {
    cleanTmpDir = true;
    #tmpOnTmpfs = true;

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

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  };

  programs = {
    bash = {
      enableCompletion = true;
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    zsh = {
      enable = true;
      enableAutosuggestions = false;
      syntaxHighlighting = {
        enable = true;
      };
    };
  };

  # List services that you want to enable:
  services = {
    acpid = {
      enable = true;
    };

    cron = {
      enable = true;
      systemCronJobs = [
        "* * * * * vid bash -x ${lowBatteryNotifier} > /tmp/cron.batt.log 2>&1"
      ];
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
      # 846x476 millimeters reported by Dell XPS 13
      # $ nix-shell -p xorg.xdpyinfo
      # $ xdpyinfo | grep -B2 resolution
      monitorSection = ''
        DisplaySize 423 238
      '';
      videoDrivers = ["intel"];
      xkbOptions = "eurosign:e";
    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system = {
    stateVersion = "18.03";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
}
