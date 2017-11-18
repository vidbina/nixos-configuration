{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cool-retro-term
    rxvt_unicode
    termite
    urxvt_font_size
  ];
}
