{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    conky
    curl
    darcs
    dmenu
    dzen2
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
