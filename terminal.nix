{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    cool-retro-term
    kitty
    rxvt_unicode.terminfo
    st
    terminator
    termite
    dynamic-colors
  ];

  programs = {
    bash = {
      enableCompletion = true;
    };
  };
}
