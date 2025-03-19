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
  version = "0.0.2";
  pyproject = true;

  src = ./.;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-vGh7Fdb3GiGkuLKSbDad7m1zgH9AazvJfIRq+2xd/OU=";
  };

  nativeBuildInputs = with rustPlatform; [cargoSetupHook maturinBuildHook] ++ [openssl pkg-config perl];

  propagatedBuildInputs = [openssl sops];

  pythonImportsCheck = [
    "sshbind"
  ];
}
