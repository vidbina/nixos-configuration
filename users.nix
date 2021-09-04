{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = "/run/current-system/sw/bin/zsh";
    users.vidbina = {
      isNormalUser = true;
      uid = 1988;
      name = "vidbina";
      description = "David Asabina <vid@bina.me>";
      createHome = true;
      cryptHomeLuks = "/dev/store/store";
      home = "/home/vidbina";
      extraGroups = [
        "beep"
        "dialout"
        "lp"
        "network"
        "networkmanager"
        "wheel"
        "wireshark"
      ];
      initialPassword = "#unsecure";
    };
  };

  environment = {
    variables = {
      QT_SCREEN_SCALE_FACTORS = "2";
      URXVT_PERL_PLUGINS = "${pkgs.rxvt_unicode-with-plugins}/lib/urxvt/perl";
    };
  };
}
