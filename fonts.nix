{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      font-awesome-ttf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };
}
