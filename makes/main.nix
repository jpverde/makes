{ makeEntrypoint
, inputs
, path
, ...
}:
makeEntrypoint {
  arguments = {
    envHeadFromHttp = makeEntrypoint {
      entrypoint = ./entrypoint-head-from-http.sh;
      name = "head-from-http";
      searchPaths = {
        envPaths = [
          inputs.makesPackages.nixpkgs.curl
          inputs.makesPackages.nixpkgs.file
          inputs.makesPackages.nixpkgs.gnutar
          inputs.makesPackages.nixpkgs.gzip
        ];
      };
    };
    envNix = inputs.makesPackages.nixpkgs.nix;
    envSrc = path "/src";
  };
  entrypoint = ''
    _HEAD_FROM_HTTP=__envHeadFromHttp__/bin/head-from-http \
    _EVALUATOR=__envSrc__/evaluator.nix \
    _NIX_BUILD=__envNix__/bin/nix-build \
    _NIX_INSTANTIATE=__envNix__/bin/nix-instantiate \
    python -m cli "$@"
  '';
  searchPaths = {
    envPaths = [
      inputs.makesPackages.nixpkgs.gnutar
      inputs.makesPackages.nixpkgs.gzip
      inputs.makesPackages.nixpkgs.python38
    ];
    envPythonPaths = [
      (path "/src")
    ];
  };
  name = "m";
}
