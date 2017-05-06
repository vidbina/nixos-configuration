{ config, pkgs, ... }:

{
  services.xserver.autoRepeatDelay = 100;
  services.xserver.autoRepeatInterval = 100;

#  services.xserver.synaptics = {
#    enable = false;
#    horizEdgeScroll = false;
#    palmDetect = true;
#    tapButtons = false;
#    twoFingerScroll = true;
#  };

#  services.xserver.multitouch = {
#    enable = true;
#    invertScroll = true;
#    ignorePalm = true;
#  };
}
