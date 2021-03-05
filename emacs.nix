{ pkgs, ... }:
let
  current = pkgs.emacs;
  bundle = (pkgs.emacsPackagesNgGen current).emacsWithPackages;
  emacs-vidbina = bundle (
    epkgs: (
      with epkgs.melpaStablePackages; [
        evil
        nix-mode
      ]
    ) ++ (
      with epkgs.melpaPackages; [
        molokai-theme
      ]
    )
  );
in
{
  environment.systemPackages = with pkgs; [
    emacs-vidbina
    fd
    ripgrep
  ];
}
