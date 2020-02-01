{ config, pkgs, ... }:

let
  timeZones = rec {
    CET = berlin;
    ET = nyc; # https://en.wikipedia.org/wiki/Eastern_Time_Zone
    PT = la; # https://en.wikipedia.org/wiki/Pacific_Time_Zone
    bangkok = {
      # https://tools.wmflabs.org/geohack/geohack.php?pagename=Thailand&params=13_45_N_100_29_E_type:city
      latitude = 13.75; longitude = 100.483333;
    };
    berlin = {
      # https://tools.wmflabs.org/geohack/geohack.php?pagename=Berlin&params=52_31_00_N_13_23_20_E_type:city(3748148)_region:DE-BE
      latitude = 52.516667; longitude = 13.388889;
    };
    nyc = {
      # https://tools.wmflabs.org/geohack/geohack.php?pagename=New_York_City&params=40.661_N_73.944_W_region:US-NY_type:city(8175133)
      latitude = 40.661; longitude = -73.944;
    };
    la = {
      # https://tools.wmflabs.org/geohack/geohack.php?pagename=Los_Angeles&params=34_03_N_118_15_W_region:US-CA_type:city(3792621)
      latitudue = 34.05; longitude = -118.25;
    };
    paramaribo = {
      # https://tools.wmflabs.org/geohack/geohack.php?pagename=Paramaribo&params=5_51_8_N_55_12_14_W_region:SR_type:city(240924)
      latitude = 5.852222; longitude = -55.203889;
    };
  };
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

  fileSystems."/nix" = {
    device = "/dev/nvme0n1p6";
    fsType = "btrfs";
    neededForBoot = true;
    options = [ "noatime" ];
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
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  location = {
    provider = "manual";
  } // timeZones.bangkok;

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

    redshift = {
      enable = false;
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
            url = "https://gitlab.com/vidbina/asabina-slim-theme/-/archive/a3698d20e133bf1765adcbec9d2de87ac5fdf0e3/asabina-slim-theme-a3698d20e133bf1765adcbec9d2de87ac5fdf0e3.tar.gz";
            sha256 = "1xw58r6g2i3j6qkrdmxlslm11d3072irrc7r4kh8jj64cnqz9xx5";
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
