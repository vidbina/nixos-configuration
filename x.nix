{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xcalib
    xclip
    (makeDesktopItem {
      name = "xsel-web";
      exec = "echo \"%u\" | xsel -ib";
      comment = "Open link by copying it into the clipboard with xsel";
      desktopName = "xsel-web";
      type = "Application";
      categories = [ "Application;Network;WebBrowser;" ];
      mimeType = lib.concatStringsSep ";" [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/ftp"
      ];
    })
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
    xtrlock-pam
  ];

  services = {
    # Enable the X11 windowing system.
    xserver = {
      autorun = true;
      # dpi = 180;
      displayManager = {
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
}
