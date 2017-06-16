{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qesteidutil
  ];

  services.pcscd = {
    enable = true;
  };
}

