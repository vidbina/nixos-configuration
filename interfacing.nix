{ config, pkgs, ... }:

{
  services.xserver.autoRepeatDelay = 180;
  services.xserver.autoRepeatInterval = 50;

  services.xserver.synaptics = {
    enable = false;
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

  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
    clickMethod = "clickfinger";
#   scrollMethod = "twofinger";
    disableWhileTyping = true;
  };
}
