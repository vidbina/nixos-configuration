{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mb2md
    msmtp
    neomutt
    notmuch
    notmuch-mutt
    offlineimap
    thunderbird
    urlview
  ];
}
