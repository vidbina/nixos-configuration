{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    khal
    tasksh
    taskwarrior
    timewarrior
  ];
}
