{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cool-retro-term
    rxvt_unicode-with-plugins
    termite
    urxvt_font_size
  ];
}
