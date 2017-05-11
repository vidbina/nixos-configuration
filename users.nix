{ config, pkgs, ... }:

{
  networking.hostName = "bina.me"; # callsign

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = "/run/current-system/sw/bin/zsh";
    extraUsers.vid = {
      isNormalUser = true;
      # uid = 1988;
      description = "David Asabina";
      extraGroups = [
        "docker"
        "networkmanager"
        "wheel"
      ];
      initialPassword = "#unsecure";
    };
  };
  
}
