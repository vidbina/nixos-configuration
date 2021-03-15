{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      emojione
      fira-code
      font-awesome-ttf
      noto-fonts-emoji
      powerline-fonts
    ];
    fontconfig.defaultFonts.monospace = [
      "DejaVu Sans Mono"
      "EmojiOne Color"
      "Fira Code Nerd"
      "Noto Color Emoji"
      "Noto Emoji"
    ];
  };
}
