{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xcalib
    xclip
    xkblayout-state
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
    xtruss
  ];

  programs = {
    slock = { enable = true; };
  };

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
      };

      exportConfiguration = true;
      layout = "us";
      # TODO: Study libinput, modules
      xkbOptions = builtins.concatStringsSep "," [
        "eurosign:e"
        "caps:ctrl_modifier"
      ];
    };

    # https://nixos.wiki/wiki/Logind
    logind = {
      lidSwitch = "suspend";
    };
  };

  systemd.services.lock-before-suspend = {
    # https://www.jvt.me/posts/2019/12/03/lock-before-suspend-systemd/
    description = "Lock X before suspend";
    wantedBy = [ "suspend.target" "suspend-then-hibernate.target" ];
    before = [ "sleep.target" ];
    serviceConfig = {
      User = config.my-config.handle;
      Environment = "DISPLAY=:0";
      ExecStart = ''${pkgs.slock}/bin/slock'';
    };
  };
}
