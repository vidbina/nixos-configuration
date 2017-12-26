{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blueman
    puredata
  ];

  hardware.bluetooth = {
    enable = true;
  };
}
