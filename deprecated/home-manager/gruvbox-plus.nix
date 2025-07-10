{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "gruvbox-gtk-theme";
  version = "latest";

  src = pkgs.fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "master";
    sha256 = "LOizbRbPj3X0B0bED6fRcwxYeRFY8vtLk0i64pqyIyY=";
  };

  installPhase = ''
    mkdir -p $out/share/themes/GruvboxPlus
    cp -r $src/* $out/share/themes/GruvboxPlus
  '';
}
