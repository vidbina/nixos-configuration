{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi               # show batt status and other ACPI info
    arandr
    ctags              # generate tags
    curl
    dbus-map
    dict
    entr
    exfat              # for handling FAT partitions
    file
    fzf
    gnome3.eog         # for image viewing
    gnupg22
    gotop
    gucharmap          # GUI charmap
    hardinfo           # system profiler and benchmark tool
    htop               # for viewing process metrics
    indent
    iotop
    (josm.overrideAttrs(oldAttrs: rec {
      buildCommand = ''
        mkdir -p $out/bin $out/share/java
        cp -v $src $out/share/java/josm.jar

        makeWrapper ${jre10}/bin/java $out/bin/josm \
          --add-flags "-Dsun.java2d.uiScale=1.3" \
          --add-flags "-jar $out/share/java/josm.jar"

        mkdir -p $out/share/applications
        cp $desktopItem/share/applications"/"* $out/share/applications
        mkdir -p $out/share/pixmaps
        ${unzip}/bin/unzip -p $src images/logo_48x48x32.png > $out/share/pixmaps/josm.png
      '';
    }))
    libnotify
    mc
    networkmanagerapplet
    nix
    nix-prefetch-git
    nixpkgs-lint
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    pciutils
    pmtools            # ACPI utils
    pstree
    pv
    python36           # we all need a python interpreter sometimes
    ranger             # TUI file mananager
    redshift
    screenfetch
    scrot
    st
    tabbed
    tcpdump
    tmux
    transmission       # for Torrent downloads
    trayer
    tree               # pkgs/tools/system/tree
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
    zbar
    zip
  ];
}
