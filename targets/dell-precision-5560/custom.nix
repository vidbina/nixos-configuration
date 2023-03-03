{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    glibc
    libva-utils
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware = {
    # https://nixos.wiki/wiki/OpenGL
    # https://nixos.wiki/wiki/Accelerated_Video_Playback
    opengl = {
      enable = true;

      driSupport = true;
      driSupport32Bit = true;

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
        nvidia-vaapi-driver
      ];
    };

    # https://nixos.wiki/wiki/Nvidia
    nvidia.powerManagement.enable = true;
  };

  # https://nixos.org/manual/nixos/stable/#sec-x11--graphics-cards-intel
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
}
