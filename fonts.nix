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
      "DejaVu Sans Mono"
      "EmojiOne Color"
      "Fira Code Nerd"
      "Noto Color Emoji"
      "Noto Emoji"
    ];
  };
}
