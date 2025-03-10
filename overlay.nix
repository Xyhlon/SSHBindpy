_: prev: {
  pythonPackagesExtensions =
    prev.pythonPackagesExtensions
    ++ [(py-final: py-prev: {sshbind = py-final.callPackage ./. {};})];
}
