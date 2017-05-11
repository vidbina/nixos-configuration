{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  enableFontDir = true;
  enableGhostscriptFonts = true;
  fonts = with pkgs; [
    font-awesome-ttf
  ];
}

