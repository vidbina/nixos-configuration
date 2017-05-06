{ config, pkgs, ... }:

{
  services.xserver.autoRepeatDelay = 300;
  services.xserver.autoRepeatInterval = 500;

#  services.xserver.synaptics = {
#    enable = false;
#    horizEdgeScroll = false;
#    palmDetect = true;
#    tapButtons = false;
#    twoFingerScroll = true;
#  };

  services.xserver.multitouch = {
    enable = true;
    invertScroll = true;
    ignorePalm = true;
  };
}
