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
    cmake
    coreutils
    emacs-vidbina
    fd
    jupyter-for-emacs
    multimarkdown
    ripgrep-for-doom-emacs

    (makeDesktopItem {
      name = "org-protocol";
      exec = "emacsclient %u";
      comment = "Org Protocol";
      desktopName = "org-protocol";
      type = "Application";
      mimeType = "x-scheme-handler/org-protocol";
    })
  ];

  services = {
    emacs = {
      # Restart using `systemctl --user restart emacs`
      enable = false;
      package = emacs-vidbina;
    };
  };
}
