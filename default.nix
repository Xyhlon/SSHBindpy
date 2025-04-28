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
  version = "0.0.3";
  pyproject = true;

  src = ./.;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-1GE4FabJJfy9bUm+aKrHVlWWczD74aOeTPMPiNkIiM0=";
  };

  nativeBuildInputs = with rustPlatform; [cargoSetupHook maturinBuildHook] ++ [openssl pkg-config perl];

  propagatedBuildInputs = [openssl sops];

  pythonImportsCheck = [
    "sshbind"
  ];
}
