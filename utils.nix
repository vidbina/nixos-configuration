{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi               # show batt status and other ACPI info
    apvlv              # pdf reader
    arandr
    ctags              # generate tags
    curl
    dbus-map
    entr
    exfat              # for handling FAT partitions
    file
    fzf
    gnome3.eog         # for image viewing
    gnupg22
    gucharmap          # GUI charmap
    hardinfo           # system profiler and benchmark tool
    htop               # for viewing process metrics
    indent
    iotop
    libnotify
    mc
    networkmanagerapplet
    nix
    nix-prefetch-git
    nixpkgs-lint
    pass
    pciutils
    pmtools            # ACPI utils
    pstree
    pv
    python36           # we all need a python interpreter sometimes
    ranger             # TUI file mananager
    #redshift
    screenfetch
    scrot
    st
    tabbed
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
    xclip
    xfe                # GUI file manager
    xorg.xev
    xorg.xhost
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xprop
    xsel
    xtrlock-pam
    zip
  ];
}
