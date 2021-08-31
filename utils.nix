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
  rofi-vidbina = with pkgs; rofi.override {
    plugins = [
      rofi-calc
      rofi-emoji
    ];
  };
in
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config = {
  };
  environment.systemPackages = with pkgs; [
    acpi # show batt status and other ACPI info
    arandr
    bat # fancy cat (in Rust)
    beep
    ccze
    ctags # generate tags
    curl
    dbus-map
    dict
    duc # disk usage utility (view disk space usage)
    entr
    exa # fancy ls (in Rust)
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
    imagemagick
    jmtpfs
    libnotify
    mc
    networkmanagerapplet
    nix-prefetch-git
    nixpkgs-fmt
    nixpkgs-lint
    lxappearance
    p7zip
    pass-vidbina
    pciutils
    pinentry_qt5
    pmtools # ACPI utils
    pstree
    pv
    python36 # we all need a python interpreter sometimes
    ranger # TUI file mananager
    redshift
    rofi-vidbina
    screenfetch
    scrot
    slop
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
    webkitgtk
    wget
    whois
    zbar
    zip
  ];
}
