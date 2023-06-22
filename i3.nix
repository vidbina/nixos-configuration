{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    i3status
  ];

  services.xserver = {
    windowManager = pkgs.lib.mkForce {
      default = "i3";
      i3 = {
        enable = true;
      };
    };
  };
}
