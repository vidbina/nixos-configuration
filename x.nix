{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xcalib
    xclip
    xfe # GUI file manager
    xorg.xbacklight
    xorg.xdpyinfo
    xorg.xev
    xorg.xhost
    xorg.xkbcomp
    xorg.xkill
    xorg.xmodmap
    xorg.xprop
    xorg.xwininfo
    xrectsel
    xsel
    xsettingsd
    xtrlock-pam
    xtruss
  ];

  services = {
    urxvtd = {
      enable = true;
    };

    # TODO: Use usbguard

    # Enable the X11 windowing system.
    xserver = {
      enable = true;

      autorun = true;

      displayManager = {
        lightdm = {
          enable = true;
        };

        sessionCommands = ''
          alias freeze="${pkgs.xtrlock-pam}/bin/xtrlock-pam -b none"
        '';
      };

      exportConfiguration = true;
      layout = "us";
      # TODO: Study libinput, modules
      videoDrivers = [ "intel" ];
      xkbOptions = builtins.concatStringsSep "," [
        "eurosign:e"
        "caps:ctrl_modifier"
      ];
    };

    # https://nixos.wiki/wiki/Logind
    logind = {
      lidSwitch = "suspend-then-hibernate";
    };
  };

  systemd.services.lock-before-suspend = {
    description = "Lock X before suspend";
    wantedBy = [ "suspend.target" ];
    before = [ "suspend.target" ];
    serviceConfig = {
      User = config.my-config.handle;
      Environment = "DISPLAY=:0";
      ExecStart = ''${pkgs.xtrlock-pam}/bin/xtrlock-pam -b none'';
    };
  };
}
