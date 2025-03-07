{
  lib,
  buildPythonPackage,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  sops,
  pkg-config,
}:
buildPythonPackage rec {
  pname = "sshbindpy";
  version = "0.0.1";
  pyproject = true;

  src = ./.;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-2YcdX5j2gpEBwCcxtTXBg1bssu7iqQAsHbfHFdO8h6k=";
  };

  nativeBuildInputs = with rustPlatform; [cargoSetupHook maturinBuildHook] ++ [openssl pkg-config];

  propagatedBuildInputs = [openssl sops];

  pythonImportsCheck = [
    "SSHBindpy"
  ];
}
