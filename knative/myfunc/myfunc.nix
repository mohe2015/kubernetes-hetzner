# nix repl
# :l <nixpkgs>
{ pkgs ? (import <nixpkgs> { config = { }; }).pkgsCross.musl64
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
} # 37.32MB/37.32MB

# nix-build myfunc/myfunc.nix