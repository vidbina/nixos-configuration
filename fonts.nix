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
      #iosevka
      noto-fonts-emoji
      # TODO: Use Powerline fonts
      powerline-fonts
    ];
    fontconfig.defaultFonts.monospace = [
      "DejaVu Sans Mono"
      "Iosevka "
      "Fira Code Nerd"
    ];
    fontconfig.defaultFonts.emoji = [
      "EmojiOne Color"
      "Noto Color Emoji"
      "Noto Emoji"
    ];
  };
}
