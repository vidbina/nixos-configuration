{ config, pkgs, ... }:

  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [
    (steam.override { newStdcpp = true; })
  ];
}
