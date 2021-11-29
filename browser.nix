{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    qutebrowser
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
