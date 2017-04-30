{ config, pkgs, ... }:

{
  services.xserver = {
    synaptics = {
      enable = true;
      horizEdgeScroll = false;
      palmDetect = true;
      twoFingerScroll = true;
      vertEdgeScroll = false;
    };
    windowManager = pkgs.lib.mkForce {
      default = "i3";
      i3 = {
        enable = true;
      };
    };
  };
}
