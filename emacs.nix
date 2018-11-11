{ pkgs }:

let
  current = pkgs.emacs;
  bundle = (pkgs.emacsPackagesNgGen current).emacsWithPackages;
  complete = bundle(epkgs: (with epkgs.melpaStablePackages; [
    evil
    nix-mode
  ]) ++ (with epkgs.melpaPackages; [
    molokai-theme
  ]));
in complete
