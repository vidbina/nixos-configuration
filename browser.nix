{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    qutebrowser
    chromium
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
