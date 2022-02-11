{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    cool-retro-term
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
    zsh.enable = true;
  };
}
