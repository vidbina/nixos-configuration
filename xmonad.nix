{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    compton
    conky
    dmenu
    dzen2
    gmrun
    haskellPackages.taffybar
    haskellPackages.xmobar
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
