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
        pdf-tools
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
    fd
    ripgrep-for-doom-emacs
  ];

  services = {
    emacs = {
      # Restart using `systemctl --user restart emacs`
      enable = true;
      package = emacs-vidbina;
    };
  };
}
