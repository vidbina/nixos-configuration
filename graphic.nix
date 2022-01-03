{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    aseprite-unfree
    #blender
    #fontforge-gtk
    ditaa
    drawio
    gimp
    glxinfo # test utils for OpenGL
    gnuplot
    graphviz
    #gmsh
    inkscape
    plantuml-vidbina
    #krita
  ];

  nixpkgs.overlays = [
    (final: prev: {
      # define own version of plantuml
      plantuml-vidbina = with prev;
        let
          pname = "plantuml";
          version = "1.2021.13";
          src = fetchFromGitHub {
            owner = "plantuml";
            repo = "plantuml";
            rev = "v${version}";
            sha256 = "sha256-J/VLxWiqJr9/vbzg14HiZars1TdSeV2kUoX8WOx/lnQ=";
          };

          repository = stdenv.mkDerivation {
            # https://nixos.org/manual/nixpkgs/unstable/#double-invocation
            name = "${pname}-repository";
            # NOTE: Was buildInputs in Nixpkgs documentation
            nativeBuildInputs = [ maven ];
            inherit src;
            buildPhase = ''
              mvn package -Dmaven.repo.local=$out
            '';

            # keep only *.{pom,jar,sha1,nbm} and delete all ephemeral files with lastModified timestamps inside
            installPhase = ''
              find $out -type f \
              -name \*.lastUpdated -or \
              -name resolver-status.properties -or \
              -name _remote.repositories \
              -delete
            '';

            # don't do any fixup
            dontFixup = true;
            outputHashAlgo = "sha256";
            outputHashMode = "recursive";
            # replace this with the correct SHA256
            outputHash = "sha256-VE86evwyHv8znhFeDi1iOvxAnLXjfxg1hHqWSgw5c9c=";
          };

          #elk-full = stdenv.mkDerivation {
          #  # https://www.eclipse.org/elk/documentation/contributors/buildingelk.html
          #  pname = "elk"
          #  version = "0.7.1"
          #  src = fetchFromGitHub {
          #    owner = "eclipse";
          #    repo = "elk";
          #    rev = "v${version}";
          #    sha256 = lib.fakeSha256;
          #  }
          #};
        in
        stdenv.mkDerivation {
          # https://nixos.org/manual/nixpkgs/unstable/#runnable-jar
          inherit pname version src;

          buildInputs = [ tree maven makeWrapper graphviz ];

          buildPhase = ''
            echo "Using repository ${repository}"
            mvn --offline -Dmaven.repo.local=${repository} package;
          '';

          installPhase = ''
            mkdir -p $out/bin

            classpath=$(find ${repository} -name "*.jar" -printf ':%h/%f');
            install -Dm644 target/${pname}-${version}-SNAPSHOT.jar $out/lib/plantuml.jar

            # create a wrapper that will automatically set the classpath
            # this should be the paths from the dependency derivation
            makeWrapper ${jre}/bin/java $out/bin/${pname} \
            --add-flags "-classpath $out/share/java/${pname}-${version}-SNAPSHOT.jar:''${classpath#:}" \
            --argv0 plantuml \
            --set GRAPHVIZ_DOT ${graphviz}/bin/dot \
            --add-flags "-jar $out/lib/plantuml.jar"
          '';
        };
    })
  ];
}
