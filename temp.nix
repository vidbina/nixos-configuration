{ config, pkgs, ... }:

{
  # TODO: cleanup later
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    dunst              # for displaying IBus Notifications
    ibus-with-plugins  # for handling input modes (emojis too)
  ];

  programs.digitalbitbox.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus = {
      engines = with pkgs.ibus-engines; [
        uniemoji
      ];
    };
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
