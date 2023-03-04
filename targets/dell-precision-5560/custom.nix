{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    glibc
    libva-utils
    vulkan-tools
  ];

  nixpkgs.config.packageOverrides = pkgs: {
  };

  hardware = {
    # https://nixos.wiki/wiki/OpenGL
    # https://nixos.wiki/wiki/Accelerated_Video_Playback
    opengl = {
      enable = true;

      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        # LIBVA_DRIVER_NAME=iHD
        intel-media-driver

        # New additions
        vaapi-intel-hybrid
        nvidia-vaapi-driver
      ];
    };

    # https://nixos.wiki/wiki/Nvidia
    nvidia.powerManagement.enable = true;
  };

  # https://nixos.org/manual/nixos/stable/#sec-x11--graphics-cards-intel

  # Listing just the NVIDIA driver as per:
  # https://github.com/NixOS/nixpkgs/issues/108018
  services.xserver.videoDrivers = [ "nvidia" ];
}
