{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    apvlv
    arandr
    conky
    curl
    dmenu
    dzen2
    file
    gnome3.eog
    gnupg21
    hardinfo
    libnotify
    mc
    neovim
    notify-osd
    oh-my-zsh
    pass
    pciutils
    pmtools
    pstree
    screenfetch
    scrot
    st
    tcpdump
    tmux
    torbrowser
    tree # pkgs/tools/system/tree
    unzip
    usbutils
    w3m
    wget
    whois
    xclip
    xlockmore
    xorg.xev
    xorg.xhost
    xorg.xkbcomp
    xorg.xmodmap
  ];
}
