{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mutt
    offlineimap
    sup
  ];
}

