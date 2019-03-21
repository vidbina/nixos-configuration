{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    httpie
    qutebrowser
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
