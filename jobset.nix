# We define bootstrap_pkgs variable in the jobset definition. This is
# only used to checkout the specified nixpkgs commit.
{ bootstrap_pkgs ? <nixpkgs>
, fetched ? import ./nixpkgs-fetch.nix { nixpkgs = bootstrap_pkgs; }
, _pkgs ? fetched.pkgs
, _contrail ? fetched.contrail
}:

let
  pkgs = import _pkgs {};
  lib = import ./lib pkgs;
  default = import ./default.nix { nixpkgs = _pkgs; contrail = _contrail; };
  genDockerPushJobs = drvs:
    pkgs.lib.mapAttrs' (n: v: pkgs.lib.nameValuePair ("docker-push-" + n) (lib.dockerPushImage v)) drvs;
in
  {
    ci.hydraImage = lib.dockerImageBuildProduct default.ci.hydraImage;
    ci.pushHydraImage = lib.dockerPushImage default.ci.hydraImage;
    contrail = default.contrail;
    images = pkgs.lib.mapAttrs (n: v: lib.dockerImageBuildProduct v) default.images;
    pushImages = genDockerPushJobs default.images;
  }
