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
    ghcid
    gitAndTools.ghorg
    git
    git-lfs
    github-cli
    glibc
    gnumake
    go
    go-jira
    html-tidy
    httpie
    httplab # interactive web server
    jq # pretty-print JSON
    k9s
    neovim
    shfmt
    sqlite_3_31_1
    subversion
    wuzz # cURL-like TUI HTTP request inspection tool
    xxd
    yq # pretty-print YAML
  ]
  ++
  (with haskellPackages; [
    #hfmt # broken, see ~/.config/nixpkgs/config.nix
    #hadolint # broken, see ~/.config/nixpkgs/config.nix
    apply-refact # for hlint --refactor
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
