{ config, pkgs, ... }:
let
  pathIfExists = (p: if (builtins.pathExists p) then [ p ] else [ ]);

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
  imports = [
    ./users.nix

    # necessary evils
    ./unfree.nix

    ./utils.nix

    # basics
    ./dev.nix
    ./fonts.nix
    ./interfacing.nix
    ./terminal.nix
    ./net.nix

    # X
    ./x.nix
    ./xmonad.nix

    # other
    ./audio.nix
    ./browser.nix
    ./cad.nix # CAD tools (mostly 3d)
    ./chat.nix
    ./crypto.nix
    ./doc.nix
    #./eid.nix       # eID packages
    ./games.nix
    ./graphic.nix # tools for graphics editing and design
    ##./i3.nix
    ./math.nix
    ./media.nix
    ./productivity.nix
    ./sec.nix
    #./temp.nix
    ./tron.nix # tools for electronics engineering
    #./unity3d.nix
    ./virt.nix

    # 3rd-party caches
    ./caches.nix
  ] ++
  # FIXME: Use of absolute here doesn't scale to more machines/configs
  # FIXME: Conditional import below not working, hence system.stateVersion redef
  (pathIfExists "/home/vidbina/src/nixos-configuration/personal.nix");

  system = {
    stateVersion = "22.05";
  };

  console = {
    earlySetup = true;
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
  };

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

    blueman.enable = true;

    cron = {
      enable = true;
      systemCronJobs =
        let
          userName = config.my-config.name;
        in
        [
          "* * * * * ${userName} bash -x ${lowBatteryNotifier} > /tmp/cron.batt.log 2>&1"
        ];
    };

    illum = {
      enable = true;
    };

    # Enable CUPS to print documents.
    # printing.enable = true;

    tlp = {
      settings = {
        #https://linrunner.de/tlp/settings/platform.html
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # https://discourse.nixos.org/t/how-to-switch-cpu-governor-on-battery-power/8446/4
        # https://linrunner.de/tlp/settings/processor.html
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_HWP_ON_AC = "balance_performance";
        CPU_HWP_ON_BAT = "power";

        CPU_MAX_PERF_ON_BAT = 30;

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # https://github.com/linrunner/TLP/issues/122
        # https://linrunner.de/tlp/settings/network.html
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 1;

        # https://linrunner.de/tlp/settings/runtimepm.html
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
      };
    };

    udisks2 = {
      enable = true;
    };
  };

  # TODO: Use a dict of named coordinates and fetch a given location from that dict
  location = {
    provider = "manual";
    # Berlin
    latitude = 52.520008;
    longitude = 13.404954;
    # Thailand/Bangkok
    # USA/LA
    # USA/NYC
    # Suriname/Paramaribo
    # Curacao/Willemstad
  };

  nix = {
    settings.sandbox = true;
  };
}
