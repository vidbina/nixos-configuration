{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
in emacsWithPackages(epkgs: (with epkgs.melpaStablePackages; [
  evil
  monokai-theme 
]) ++ (with epkgs.melpaPackages; [
  molokai-theme
]))
