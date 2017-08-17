{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    puredata
  ];

  hardware.bluetooth = {
    enable = true;
  };
}
