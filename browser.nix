{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
  ];

  nixpkgs.config.firefox = {
    enableEsteid = true;
  };
}
