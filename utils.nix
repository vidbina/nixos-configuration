{ config, pkgs, ... }:
let
  #josm-vidbina = with pkgs; josm.overrideAttrs (oldAttrs: rec {
  #  buildCommand = ''
  #    mkdir -p $out/bin $out/share/java
  #    cp -v $src $out/share/java/josm.jar

  #    makeWrapper ${jdk11}/bin/java $out/bin/josm \
  #      --add-flags "-Dsun.java2d.uiScale=1.3" \
  #      --add-flags "-jar $out/share/java/josm.jar"

  #    mkdir -p $out/share/applications
  #    cp $desktopItem/share/applications"/"* $out/share/applications
  #    mkdir -p $out/share/pixmaps
  #    ${unzip}/bin/unzip -p $src images/logo_48x48x32.png > $out/share/pixmaps/josm.png
  #  '';
  #});

  pass-vidbina = with pkgs; pass.withExtensions (exts: [ exts.pass-otp ]);
in
{
  environment.systemPackages = with pkgs; [
    acpi # show batt status and other ACPI info
    arandr
    beep
    ccze
    ctags # generate tags
    curl
    dbus-map
    dict
    duc # disk usage utility (view disk space usage)
    entr
    exfat # for handling FAT partitions
    file
    fzf
    glances
    gnome3.eog # for image viewing
    gnum4 # m4 for colorit, which is installed with dict
    gnupg22
    gotop
    gucharmap # GUI charmap
    hardinfo # system profiler and benchmark tool
    htop # for viewing process metrics
    indent
    iotop
    jmtpfs
    libnotify
    mc
    networkmanagerapplet
    nix
    nix-prefetch-git
    nixpkgs-fmt
    nixpkgs-lint
    pass-vidbina
    pciutils
    pinentry_qt5
    pmtools # ACPI utils
    pstree
    pv
    python36 # we all need a python interpreter sometimes
    ranger # TUI file mananager
    redshift
    screenfetch
    scrot
    st
    tabbed
    tcpdump
    tmux
    transmission # for Torrent downloads
    trayer
    tree # pkgs/tools/system/tree
    udisks2
    unzip
    usbutils
    w3m
    wget
    whois
    xclip
    xfe # GUI file manager
    xorg.xdpyinfo
    xorg.xev
    xorg.xhost
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xprop
    xorg.xwininfo
    xrectsel
    xsel
    xtrlock-pam
    zbar
    zip
  ];
}
