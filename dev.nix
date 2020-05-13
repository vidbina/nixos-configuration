{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # deno # WIP
    #htmlTidy
    #mitscheme
    #stdenv
    (import ./emacs.nix { inherit pkgs; })
    asciinema
    bazaar
    cmakeCurses
    darcs
    gdb
    ghc
    git
    git-lfs
    glibc
    gnumake
    go
    httpie
    jq
    neovim
    shfmt
    shfmt
    sqlite_3_31_1
    subversion
    xxd
  ]
  ++
  (with haskellPackages; [
    #hfmt # broken, see ~/.config/nixpkgs/config.nix
    #hadolint # broken, see ~/.config/nixpkgs/config.nix
    hindent
    hlint
    stylish-haskell
  ])
  ++
  (with pythonPackages; [
    yamllint
  ])
  ;

  nixpkgs.config = {};
}
