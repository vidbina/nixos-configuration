{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    isync
    mb2md
    msmtp
    mu
    neomutt
    notmuch
    notmuch-mutt
    offlineimap
    thunderbird
    urlview
  ];
}
