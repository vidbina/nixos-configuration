{ config, pkgs, ... }:

{
  services.xserver.autoRepeatDelay = 150;
  services.xserver.autoRepeatInterval = 100;

  services.xserver.synaptics = {
    enable = true;
    horizEdgeScroll = false;
    palmDetect = true;
    tapButtons = false;
    twoFingerScroll = true;
    # TODO: invert scrolling
  };

  services.xserver.multitouch = {
    enable = false;
    invertScroll = true;
    ignorePalm = true;
    # TODO: improve responsiveness
  };
}
