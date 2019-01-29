{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    khal
    tasksh
    taskwarrior
    timewarrior
    (ganttproject-bin.overrideAttrs(oldAttrs: rec {
      version = "2.8.9";
      name = "ganttproject-bin-${version}";
      src = fetchzip {
        sha256 = "1fmfrsy9z2nff0bxwj7xsfbwkb9y1dmssvy5wkmf9ngihyzj3w1k";
        url = "https://dl.ganttproject.biz/ganttproject-${version}/ganttproject-${version}-r2335.zip";
      };
      installPhase = let

        desktopItem = makeDesktopItem {
          name = "ganttproject";
          exec = "ganttproject";
          icon = "ganttproject";
          desktopName = "GanttProject";
          genericName = "Shedule and manage projects";
          comment = oldAttrs.meta.description;
          categories = "Office;Application;";
        };

      in ''
        mkdir -pv "$out/share/ganttproject"
        cp -rv *  "$out/share/ganttproject"

        mkdir -pv "$out/bin"
        wrapProgram "$out/share/ganttproject/ganttproject" \
          --set JAVA_HOME "${jre}" \
          --set _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on"
        mv -v "$out/share/ganttproject/ganttproject" "$out/bin"

        #install -v -Dm644 \
        #  plugins/net.sourceforge.ganttproject/data/resources/icons/ganttproject.png \
        #  "$out/share/pixmaps/ganttproject.png"
        cp -rv "${desktopItem}/share/applications" "$out/share"
      '';
    }))
    vym
  ];
}
