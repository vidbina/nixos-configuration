{ config, pkgs, ... }:

{
  # TODO: cleanup later
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
  ];

  programs.digitalbitbox.enable = true;
}
