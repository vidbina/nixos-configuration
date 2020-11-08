{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mb2md
    msmtp
    neomutt
    offlineimap
    thunderbird
  ];
}
