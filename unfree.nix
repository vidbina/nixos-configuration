{ pkgs, ... }:

{
  nixpkgs.config = with pkgs; {
    allowUnfreePredicate = (pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ]);
  };
}
