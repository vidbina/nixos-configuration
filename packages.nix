{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    apvlv
    arandr
    ctags
    curl
    dbus-map
    entr
    exfat              # for handling FAT partitions
    file
    fzf
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
    nix
    pass
    pciutils
    pmtools
    pstree
    python36           # we all need a python interpreter sometimes
    ranger             # TUI file mananager
    redshift
    screenfetch
    scrot
    st
    tcpdump
    tmux
    transmission       # for Torrent downloads
    trayer
    tree # pkgs/tools/system/tree
    udisks2
    unzip
    usbutils
    vym
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
    zip
    #./customPkgs/qeletrotech
  ];
}
