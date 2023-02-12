{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware = {
    # https://nixos.wiki/wiki/OpenGL
    # https://nixos.wiki/wiki/Accelerated_Video_Playback
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        mesa.drivers

        # LIBVA_DRIVER_NAME=iHD
        intel-media-driver

        # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl

        # New additions
        vaapi-intel-hybrid
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    # https://nixos.wiki/wiki/Nvidia
    nvidia.powerManagement.enable = true;
  };

  services.xserver.videoDrivers = [ "intel" "nvidia" ];
}
