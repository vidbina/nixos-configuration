{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    (import ./emacs.nix { inherit pkgs; })
    asciinema
    bazaar
    cmakeCurses
    darcs
    ghc
    git
    git-lfs
    glibc
    gnumake
    go
    jq
    mitscheme
    neovim
    stdenv
    xxd
  ];

  nixpkgs.config = {
  };
}
