{ config, options, pkgs, ... }:
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
  nixpkgs.config = { };
  environment.systemPackages = with pkgs; [
    acpi # show batt status and other ACPI info
    acpica-tools # ACPI utils
    arandr
    beep
    brightnessctl
    ccze
    ctags # generate tags
    curl
    dbus-map
    delta # diff (in Rust)
    dict
    duc # disk usage utility (view disk space usage)
    entr
    exa # fancy ls (in Rust)
    exfat # for handling FAT partitions
    file
    fzf
    glances
    gnome.eog # for image viewing
    gnum4 # m4 for colorit, which is installed with dict
    gnupg
    gotop
    gucharmap # GUI charmap
    hardinfo # system profiler and benchmark tool
    htop # for viewing process metrics
    imagemagick
    indent
    iotop
    jmtpfs
    libnotify
    lxappearance
    mc
    my-nixos-option
    networkmanagerapplet
    nix-prefetch-git
    nixpkgs-fmt
    nixpkgs-lint
    p7zip
    pass-vidbina
    pciutils
    pinentry-qt
    pstree
    pv
    ranger # TUI file mananager
    screenfetch
    scrot
    slop
    ssh-to-age
    tabbed
    tcpdump
    transmission # for Torrent downloads
    trayer
    tree # pkgs/tools/system/tree
    udisks2
    unzip
    usbutils
    w3m
    webkitgtk
    wget
    whois
    xh # slicker HTTPie (in Rust)
    zbar
    zip
  ];
}
