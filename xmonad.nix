{ config, pkgs, ... }:

let
  new-libmpd = with pkgs; haskell.lib.overrideCabal haskellPackages.libmpd (oldAttrs: {
    version = "0.9.0.10";
    sha256 = "0vy287mn1vk8kvij5i3hc0p02l886cpsq5dds7kl6g520si3abkb";
    revision = null;
    editedCabalFile = null;
    libraryHaskellDepends = oldAttrs.libraryHaskellDepends ++ (with haskellPackages; [
      safe-exceptions
    ]);
  });
  my-xmobar = with pkgs; haskell.lib.overrideCabal haskellPackages.xmobar (oldAttrs: {
    version = "0.33";
    sha256 = "1hr3qqykc5givcpcwrr9f2y920jmiinmxm5mcy6qgpgymgwqb618";

    libraryHaskellDepends = oldAttrs.libraryHaskellDepends ++ [
      new-libmpd
    ];

    prePatch = ''
      sed "s#/usr/share/zoneinfo/#/etc/zoneinfo/#g" -i src/Xmobar/Plugins/DateZone.hs
      sed "s#0.30#0.30-vidbina#g" -i xmobar.cabal
      cat xmobar.cabal
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    compton
    conky
    dmenu
    dzen2
    gmrun
    my-xmobar
    hsetroot
  ];

    # NOTE: Set XMonad as wm again. Make sure to set .xmonad/xmonad.hs
  services.xserver.windowManager = pkgs.lib.mkForce {
    default = "xmonad";
    xmonad = {
      enableContribAndExtras = true;
      enable = true;
    };
  };
}
