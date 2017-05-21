{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    puredata
  ];
}
