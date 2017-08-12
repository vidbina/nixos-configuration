{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema
    cmakeCurses
    darcs
    ghc
    git
    git-lfs
    glibc
    gnumake
    mitscheme
    stdenv
  ];

  nixpkgs.config = {
  };
}
