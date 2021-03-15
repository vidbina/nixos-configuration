{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mb2md
    msmtp
    neomutt
    notmuch
    offlineimap
    thunderbird
    urlview
  ];
}
