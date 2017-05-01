{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xmobar
  ];

  services.xserver = {
    synaptics = {
      enable = true;
      horizEdgeScroll = false;
      palmDetect = true;
      tapButtons = false;
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
