{ config, pkgs, ... }:

{
  networking.hostName = "bina"; # callsign

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = "/run/current-system/sw/bin/zsh";
    users.vidbina = {
      isNormalUser = true;
      uid = 1988;
      name = "vid";
      description = "David Asabina <vid@bina>";
      createHome = true;
      cryptHomeLuks = "/dev/store/store";
      home = "/store/vidbina.home";
      extraGroups = [
        "beep"
        "dialout"
        "docker"
        "lp"
        "network"
        "networkmanager"
        "vboxsf"
        "vboxusers"
        "wheel"
        "wireshark"
      ];
      initialPassword = "#unsecure";
    };
  };

  environment = {
    variables = {
      URXVT_PERL_PLUGINS = "${pkgs.rxvt_unicode-with-plugins}/lib/urxvt/perl";
    };
  };
}
