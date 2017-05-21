{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rxvt_unicode
    urxvt_font_size
  ];
}
