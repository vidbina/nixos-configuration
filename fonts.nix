{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      emojione
      fira-code
      font-awesome-ttf
      iosevka
      noto-fonts-emoji
      powerline-fonts
    ];
    fontconfig.defaultFonts.monospace = [
      "DejaVu Sans Mono"
      "Iosevka "
      "Fira Code Nerd"
    ];
    fontconfig.defaultFonts.emoji = [
      "Noto Color Emoji"
      "EmojiOne Color"
      "Noto Emoji"
    ];
  };
}
