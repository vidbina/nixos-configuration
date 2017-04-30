{ config, pkgs, ... }:

{
  services.xserver = {
    libinput = {
      clickMethod = "clickfinger";
      scrollMethod = "twofinger"; # mimick Macbook behavior
      sendEventsMode = "disabled"; # ingore if external pointing dev is connected
      tapping = false; # mimick Macbook behavior
      enable = true;
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
