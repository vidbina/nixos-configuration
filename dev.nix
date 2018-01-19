{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema
    bazaar
    cmakeCurses
    darcs
    ghc
    git
    git-lfs
    glibc
    gnumake
    mitscheme
    stdenv
    xxd
  ];

  nixpkgs.config = {
  };
}
