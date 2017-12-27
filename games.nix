{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
  ];

  hardware.opengl.driSupport32Bit = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
    KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"
  '';
}
