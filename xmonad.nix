{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    compton
    conky
    dmenu
    hsetroot
    xmobar
  ];

  # NOTE: Set XMonad as wm again. Make sure to set .xmonad/xmonad.hs
  services.xserver = {
    displayManager.defaultSession = "none+xmonad";
    windowManager = pkgs.lib.mkForce {
      xmonad = {
        enableContribAndExtras = true;
        enable = true;
      };
    };
  };
}
