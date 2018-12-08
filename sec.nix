{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chkrootkit
    lynis
  ];
}
