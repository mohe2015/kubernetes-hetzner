{ pkgs ? import <nixpkgs> { config = { }; }
, generatedCargoNix ? ./Cargo.nix
}:
let
  basePackage = pkgs.callPackage generatedCargoNix {
    
  };
  submodulePackage = basePackage.rootCrate.build;
in
pkgs.dockerTools.buildImage {
  name = "myfunc-docker";
  config = {
    Cmd = [ "${submodulePackage}/bin/function" ];
  };
}