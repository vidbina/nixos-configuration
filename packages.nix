{ config, pkgs, ... }:
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
    pstree
    rxvt_unicode
    st
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    vim
    wget
    xorg.xev
    xorg.xmodmap
  ];
}
