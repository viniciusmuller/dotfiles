{ pkgs, ... }:

let unreal-world = pkgs.stdenv.mkDerivation rec {
  pname = "unreal-world";
  version = "3.62";

  src = pkgs.fetchurl {
    url = "http://www.unrealworld.fi/dl/3.62/linux/deb-ubuntu/urw-3.62-x86_64-linux-gnu.tar.gz";
    sha256 = "sha256-lfIbr8PGTFKzwyUWN0Uv8sP9JXpyO368+/5aisa7ntY=";
  };

  /* unpackCmd = "${pkgs.dpkg}/bin/dpkg-deb -x $curSrc ."; */

  nativeBuildInputs = [
  ];

  buildInputs = with pkgs; [
    autoPatchelfHook
  ];

  runtimeDependencies = [
    # Works fine without this except there is no sound.
    # libpulseaudio.out

    # This is a little tricky. Without it the app starts then crashes. Then it
    # brings up the crash report, which also crashes. `strace -f` hints at a
    # missing libudev.so.0.
    # (lib.getLib systemd)
  ];

  # installPhase = ''
  #   mkdir -p $out
  #   cp -r . $out/
  #   mv $out/lib/*/opera/*.so $out/lib/
  # '';

  # meta = with lib; {
  #   homepage = "https://www.opera.com";
  #   description = "Web browser";
  #   platforms = [ "x86_64-linux" ];
  #   license = licenses.unfree;
  # };
};

in
{
  home.packages = [ unreal-world ];
}
