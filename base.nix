{ config, pkgs, ... }:
let
  lowBatteryNotifier = pkgs.writeScript "lowBatteryNotifier"
    ''
      BAT_PCT=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '[0-9]+(?=%)'`
      BAT_STA=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '\w+(?=,)'`
      echo "`date` battery status:$BAT_STA percentage:$BAT_PCT"
      test $BAT_PCT -le 10 && test $BAT_PCT -gt 5 && test $BAT_STA = "Discharging" && DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send -c device -u normal   "Low Battery" "Would be wise to keep my charger nearby."
      test $BAT_PCT -le  5                        && test $BAT_STA = "Discharging" && DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send -c device -u critical "Low Battery" "Charge me or watch me die!"
    '';
in
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    cleanTmpDir = true;
    #tmpOnTmpfs = true;

    kernelModules = [
      "af_packet"
      "v4l2loopback"
    ];
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=10 card_label="v4l2-cam"
    '';
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/nvme0n1";
    };
    initrd.luks.devices = {
      "base.crypt.small" = {
        device = "/dev/nvme0n1p3"; # 100 GiB
        preLVM = true;
      };
      "store" = {
        device = "/dev/nvme0n1p5"; # 300 GiB
        preLVM = true;
      };
    };
  };

  fileSystems."/home" = {
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

  console.font = "latarcyrheb-sun32";
  # Select internationalisation properties.
  i18n = {
    #   consoleKeyMap = "us";
    #   defaultLocale = "en_US.UTF-8";
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryFlavor = "qt";
      };
    };
    light.enable = true;
  };

  # List services that you want to enable:
  services = {
    acpid = {
      enable = true;
    };

    actkbd = {
      enable = true;
      bindings = [
        { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
        { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      ];
    };

    cron = {
      enable = true;
      systemCronJobs =
        let
          userName = config.users.users.vidbina.name;
        in
        [
          "* * * * * ${userName} bash -x ${lowBatteryNotifier} > /tmp/cron.batt.log 2>&1"
        ];
    };

    illum = {
      enable = true;
    };

    redshift = {
      enable = false;
      extraOptions = [
        "-c ~/.config/redshift.conf"
      ];
    };

    # Enable CUPS to print documents.
    # printing.enable = true;


    # Enable the X11 windowing system.
    xserver = {
      autorun = true;
      # dpi = 180;
      displayManager = {
        defaultSession = "none+xmonad";

        lightdm = {
          enable = true;
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
      videoDrivers = [ "intel" ];
      xkbOptions = "eurosign:e";
    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system = {
    stateVersion = "20.03";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  # Example values:
  #   America/Los_Angeles
  #   America/Mexico_City
  #   America/New_York
  #   America/Paramaribo
  #   Asia/Bangkok
  #   Europe/Amsterdam
  #   Europe/Berlin

  # TODO: Use a dict of named coordinates and fetch a given location from that dict
  location = {
    provider = "manual";
    # Berlin
    latitude = "52.520008";
    longitude = "13.404954";
    # Thailand/Bangkok
    # USA/LA
    # USA/NYC
    # Suriname/Paramaribo
    # Curacao/Willemstad
  };
}
