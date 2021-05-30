{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
