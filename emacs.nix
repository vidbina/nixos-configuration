{ pkgs, ... }:
let
  current = pkgs.emacs;
  bundle = (pkgs.emacsPackagesNgGen current).emacsWithPackages;
  emacs-vidbina = bundle (
    epkgs:
    (
      with epkgs; [
        vterm
      ]
    ) ++ (
      with epkgs.melpaStablePackages; [
        evil
        nix-mode
      ]
    ) ++ (
      with epkgs.melpaPackages; [
        doom-modeline
        doom-themes
      ]
    )
  );
  ripgrep-for-doom-emacs = (pkgs.ripgrep.override { withPCRE2 = true; });
in
{
  environment.systemPackages = with pkgs; [
    emacs-vidbina
    fd
    ripgrep-for-doom-emacs
  ];
}
