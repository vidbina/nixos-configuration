{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    msmtp
    neomutt
    offlineimap
    sup
  ];
}

