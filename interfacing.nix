{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst              # for displaying IBus Notifications
    ibus-with-plugins  # for handling input modes (emojis too)
  ];

  i18n.inputMethod = {
    enabled = "ibus";
    ibus = {
      engines = with pkgs.ibus-engines; [
        uniemoji
      ];
    };
  };

  services.xserver.autoRepeatDelay = 180;
  services.xserver.autoRepeatInterval = 50;

  services.xserver.synaptics = {
    enable = false;
    horizEdgeScroll = false;
    palmDetect = true;
    tapButtons = false;
    twoFingerScroll = true;
    # TODO: invert scrolling
  };

  services.xserver.multitouch = {
    enable = false;
    invertScroll = true;
    ignorePalm = true;
    # TODO: improve responsiveness
  };

  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
    clickMethod = "clickfinger";
#   scrollMethod = "twofinger";
    disableWhileTyping = true;
    tapping = false;
  };

  systemd.user.services.ibus-daemon = {
    enable = true;
    #after = ["graphical.target"];
    wantedBy = [
      "multi-user.target"
      "graphical-session.target"
    ];
    description = "IBus daemon";
    script = "${pkgs.ibus-with-plugins}/bin/ibus-daemon";
    serviceConfig = {
      Restart = "always";
      StandardOutput = "syslog";
    };
  };

  systemd.user.services.dunst = {
    enable = true;
    description  = "Dunst: libnotify client";
    documentation = [
      "man:dunst(1)"
    ];
    partOf = [
      "graphical-session.target"
    ];
    wantedBy = [
      "default.target"
    ];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.dunst}/bin/dunst";
    };
  };
}
