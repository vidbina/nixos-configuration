{ config, pkgs, ... }:

{
  services.xserver.synaptics = {
    enable = true;
    horizEdgeScroll = false;
    palmDetect = true;
    tapButtons = false;
    twoFingerScroll = true;
  };

  services.xserver.multitouch = {
    enable = true;
    invertScroll = true;
    ignorePalm = true;
  };
}
