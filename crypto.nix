{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  #programs.digitalbitbox.enable = true;

  #services.trezord.enable = true;
}

