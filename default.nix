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
    hash = "sha256-nQjWppz13dSYw4ChYWrY8Szxraxg6Ua8jf8REjgfUuc=";
  };

  nativeBuildInputs = with rustPlatform; [cargoSetupHook maturinBuildHook] ++ [openssl pkg-config perl];

  propagatedBuildInputs = [openssl sops];

  pythonImportsCheck = [
    "sshbind"
  ];
}
