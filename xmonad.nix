{ config, pkgs, ... }:

{
  services.xserver = {
    libinput = {
      clickMethod = "clickfinger";
      disableWhileTyping = true;
      enable = true;
      naturalScrolling = true;
      scrollMethod = "twofinger"; # mimick Macbook behavior
      sendEventsMode = "disabled"; # ingore if external pointing dev is connected
      tapping = false; # mimick Macbook behavior
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
