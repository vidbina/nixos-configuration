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
    windowManager = {
      default = "i3";
      i3 = {
        enable = true;
      };
    };
  };
}
