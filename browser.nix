{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    nyxt
    qutebrowser
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
