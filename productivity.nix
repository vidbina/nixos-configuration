{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    khal
    tasksh
    (taskwarrior.overrideAttrs(oldAttrs: rec {
      postInstall = oldAttrs.postInstall + ''
        mkdir -p $out/share/zsh/site-functions
        ln -s ../../../share/doc/task/scripts/zsh/_task $out/share/zsh/site-functions/_task
      '';
    }))
    timewarrior
  ];
}
