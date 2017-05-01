{ config, pkgs, ... }:

{
  services.xserver = {
    synaptics = {
      enable = true;
      horizEdgeScroll = false;
      palmDetect = true;
      tapButtons = true;
      twoFingerScroll = true;
    };

    # NOTE: Set XMonad as wm again. Make sure to set .xmonad/xmonad.hs
    windowManager = pkgs.lib.mkForce {
      default = "xmonad";
      xmonad = {
        enableContribAndExtras = true;
        enable = true;
      };
    };
  };
}
