{ __nixpkgs__, makeScript, ... }:
makeScript {
  entrypoint = "dmesg";
  name = "make-htop";
  searchPaths.bin = [__nixpkgs__.util-linux];
}
