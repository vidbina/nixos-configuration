{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    minicom
    kicad
    xoscope
  ];
}
