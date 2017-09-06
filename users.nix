{ config, pkgs, ... }:

{
  networking.hostName = "bina.me"; # callsign

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
        "docker"
        "lp"
        "network"
        "networkmanager"
        "wheel"
        "vboxsf"
        "vboxusers"
      ];
      initialPassword = "#unsecure";
    };
  };
  
}
