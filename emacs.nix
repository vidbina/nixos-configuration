{ pkgs, ... }:
let
  current = pkgs.emacsUnstable;
  bundle = (pkgs.emacsPackagesNgGen current).emacsWithPackages;
  emacs-vidbina = bundle (
    epkgs:
    (
      with epkgs; [
        notmuch
        vterm
        pdf-tools
      ]
    ) ++ (
      with epkgs.melpaStablePackages; [
      ]
    ) ++ (
      with epkgs.melpaPackages; [
      ]
    )
  );
  jupyter-for-emacs = (pkgs.python39.withPackages (ps: with ps; [ jupyter ]));
  ripgrep-for-doom-emacs = (pkgs.ripgrep.override { withPCRE2 = true; });
in
{
  environment.systemPackages = with pkgs; [
    clang
    cmake
    coreutils
    fd
    jupyter-for-emacs
    multimarkdown
    ripgrep-for-doom-emacs

    (makeDesktopItem {
      name = "org-protocol";
      exec = "${emacs-vidbina}/bin/emacsclient --create-frame %u";
      comment = "Org Protocol";
      desktopName = "org-protocol";
      type = "Application";
      mimeType = "x-scheme-handler/org-protocol";
    })

    # https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-0.9.5.html
    # https://www.emacswiki.org/emacs/MailtoHandler
    # https://dev.spacekookie.de/kookie/nomicon/commit/9e5896496cfd5da5754018887f7ad3b256b3ad80.diff
    (makeDesktopItem {
      name = "emacs-mu4e";
      exec = ''
        ${emacs-vidbina}/bin/emacsclient --create-frame --eval "(browse-url-mail \"%u\")"
      '';
      comment = "Emacs mu4e";
      desktopName = "emacs-mu4e";
      type = "Application";
      mimeType = builtins.concatStringsSep ";" [
        # Email
        "x-scheme-handler/mailto"
        "message/rfc822"
      ];
    })
  ];

  services = {
    emacs = {
      # Restart using `systemctl --user restart emacs`
      enable = true;
      package = emacs-vidbina;
    };
  };
}
