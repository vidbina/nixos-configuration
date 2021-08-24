{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    nyxt
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
