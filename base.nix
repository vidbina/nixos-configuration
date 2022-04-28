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
  ] ++ (pathIfExists /home/vidbina/nixos-configuration/personal.nix);

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
        # https://discourse.nixos.org/t/how-to-switch-cpu-governor-on-battery-power/8446/4
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_MAX_PERF_ON_BAT = 40;

        # https://github.com/linrunner/TLP/issues/122
        WIFI_PWR_ON_AC = 1;
        WIFI_PWR_ON_BAT = 5;
      };
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
