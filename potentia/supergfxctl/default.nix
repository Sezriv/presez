{ lib
, fetchFromGitLab
, fetchpatch
, rustPlatform
, pkg-config
, udev
}:
rustPlatform.buildRustPackage rec {
  pname = "supergfxctl";
  version = "git-715716";
  src = fetchFromGitLab {
    owner = "asus-linux";
    repo = pname;
    rev = "715716cfd924dc2105b377d3f4cc437593f47fc6";
    sha256 = lib.fakeSha256;
  };
  cargoHash = lib.fakeSha256;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev ];

  postInstall = ''
    make install INSTALL_PROGRAM=true DESTDIR=$out prefix=
  ''; 
  };
}
