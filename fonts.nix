{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      emojione
      fira-code
      font-awesome-ttf
      iosevka
      noto-fonts-emoji
      powerline-fonts
    ];
    fontconfig.defaultFonts.monospace = [
      "Iosevka "
      "DejaVu Sans Mono"
      "Fira Code Nerd"
    ];
    fontconfig.defaultFonts.emoji = [
      "Noto Color Emoji"
      "EmojiOne Color"
      "Noto Emoji"
    ];
  };
}
