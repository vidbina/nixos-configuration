{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    cool-retro-term
    termite
  ];

  services.urxvtd.enable = true;
}
