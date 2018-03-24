{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    apvlv
    arandr
    curl
    dbus-map
    entr
    exfat              # for handling FAT partitions
    file
    gnome3.eog         # for image viewing
    gnupg22
    gucharmap          # GUI charmap
    hardinfo
    htop               # for viewing process metrics
    indent
    libnotify
    mc
    nix-repl
    nix-prefetch-git
    nixpkgs-lint
    nixUnstable
    pass
    pciutils
    pmtools
    pstree
    python36           # we all need a python interpreter sometimes
    ranger             # TUI file mananager
    screenfetch
    scrot
    st
    stellarium         # for stargazing
    tcpdump
    tmux
    transmission       # for Torrent downloads
    trayer
    tree # pkgs/tools/system/tree
    udisks2
    unzip
    usbutils
    w3m
    wget
    whois
    xautolock
    xclip
    xfe                # GUI file manager
    xlockmore
    xorg.xev
    xorg.xhost
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xprop
    xsel
    xtrlock-pam
    #./customPkgs/qeletrotech
  ];
}
