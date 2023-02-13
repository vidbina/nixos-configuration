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
}
