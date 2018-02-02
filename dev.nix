{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema
    bazaar
    cmakeCurses
    darcs
    (import ./emacs.nix { inherit pkgs; })
    ghc
    git
    git-lfs
    glibc
    gnumake
    mitscheme
    stdenv
    neovim
    xxd
  ];

  nixpkgs.config = {
  };
}
