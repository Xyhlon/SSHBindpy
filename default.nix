{
  lib,
  buildPythonPackage,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  sops,
  pkg-config,
  perl,
}:
buildPythonPackage rec {
  pname = "sshbind";
  version = "0.0.1";
  pyproject = true;

  src = ./.;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-uncMaVTvv9lkA7fp7xzTl9ny6IkmqsyGlcS4h2p8Gp0=";
  };

  nativeBuildInputs = with rustPlatform; [cargoSetupHook maturinBuildHook] ++ [openssl pkg-config perl];

  propagatedBuildInputs = [openssl sops];

  pythonImportsCheck = [
    "sshbind"
  ];
}
