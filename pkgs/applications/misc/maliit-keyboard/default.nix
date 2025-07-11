{
  mkDerivation,
  lib,
  fetchFromGitHub,

  anthy,
  hunspell,
  libchewing,
  libpinyin,
  maliit-framework,
  qtfeedback,
  qtmultimedia,
  qtquickcontrols2,
  qtgraphicaleffects,

  cmake,
  pkg-config,
  wrapGAppsHook3,
}:

mkDerivation {
  pname = "maliit-keyboard";
  version = "2.3.1-unstable-2024-09-04";

  src = fetchFromGitHub {
    owner = "maliit";
    repo = "keyboard";
    rev = "cbb0bbfa67354df76c25dbc3b1ea99a376fd15bb";
    sha256 = "sha256-6ITlV/RJkPDrnsFyeWYWaRTYTaY6NAbHDqpUZGGKyi4=";
  };

  postPatch = ''
    substituteInPlace data/schemas/org.maliit.keyboard.maliit.gschema.xml \
      --replace /usr/share "$out/share"
  '';

  buildInputs = [
    anthy
    hunspell
    libchewing
    libpinyin
    maliit-framework
    qtfeedback
    qtmultimedia
    qtquickcontrols2
    qtgraphicaleffects
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
    "-DCMAKE_INSTALL_LIBDIR=lib"
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    wrapGAppsHook3
  ];

  postInstall = ''
    glib-compile-schemas "$out"/share/glib-2.0/schemas
  '';

  meta = with lib; {
    description = "Virtual keyboard";
    mainProgram = "maliit-keyboard";
    homepage = "http://maliit.github.io/";
    license = with licenses; [
      lgpl3Only
      bsd3
      cc-by-30
    ];
    maintainers = [ ];
  };
}
