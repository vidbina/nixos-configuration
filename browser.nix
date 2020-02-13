{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    qutebrowser
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
