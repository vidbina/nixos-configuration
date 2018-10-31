{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  nixpkgs.config.firefox.enableEsteid = true;

  environment.systemPackages = with pkgs; [
    qesteidutil
  ];

  services.pcscd = {
    enable = true;
  };
}

