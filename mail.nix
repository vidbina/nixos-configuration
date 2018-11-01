{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    msmtp
    neomutt
    offlineimap
    sup
  ];
}

