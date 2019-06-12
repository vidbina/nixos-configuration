{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true; # for spotify

  environment.systemPackages = with pkgs; [
    minitube
    mpv
    #(kdenlive.overrideAttrs(oldAttrs: rec {
    #  buildInputs = oldAttrs.buildInputs ++ [ makeWrapper ];
    #  postInstall = ''
    #    wrapProgram $out/bin/kdenlive --prefix FREI0R_PATH : ${frei0r}/lib/frei0r-1
    #  '';
    #}))
    #openshot-qt
    playerctl
    shotcut
    vlc
    youtube-dl
  ];
}

