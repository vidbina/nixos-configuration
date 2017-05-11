{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    curl
    darcs
    dmenu
    font-awesome-ttf
    git
    gnome3.eog
    gnupg
    okular
    rxvt_unicode
    st
    torbrowser
    vim
    wget
    xorg.xev
    xorg.xmodmap
  ];
}
