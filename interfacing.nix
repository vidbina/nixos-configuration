{ config, pkgs, ... }:

{
  services.xserver.autoRepeatDelay = 20;
  services.xserver.autoRepeatInterval = 20;

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
#    ignorePalm = true;
  };
}
