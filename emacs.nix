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
      ]
    ) ++ (
      with epkgs.melpaPackages; [
      ]
    )
  );
  jupyter-for-emacs = (pkgs.python38.withPackages (ps: with ps; [ jupyter ]));
  ripgrep-for-doom-emacs = (pkgs.ripgrep.override { withPCRE2 = true; });
in
{
  environment.systemPackages = with pkgs; [
    clang
    coreutils
    fd
    jupyter-for-emacs
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
