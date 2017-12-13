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
    gnupg22
    hardinfo
    libnotify
    mc
    neovim
    nix-repl
    nix-prefetch-git
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
    tree # pkgs/tools/system/tree
    udisks2
    unzip
    usbutils
    w3m
    wget
    whois
    xautolock
    xclip
    xlockmore
    xorg.xev
    xorg.xhost
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xprop
    xtrlock-pam
  ];
}
