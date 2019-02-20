{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clamav
    chkrootkit
    lynis
  ];
}
