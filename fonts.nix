{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      emojione
      font-awesome-ttf
      noto-fonts-emoji
      powerline-fonts
    ];
    fontconfig.defaultFonts.monospace = [
      "DejaVu Sans Mono"
      "Noto Emoji"
      "EmojiOne Color"
      "Noto Color Emoji"
    ];
  };
}
