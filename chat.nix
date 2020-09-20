{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tdesktop
    weechat
    zoom-us
  ];
}
