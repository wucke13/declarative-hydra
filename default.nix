{ nixpkgs, declInput }:
let
  pkgs = import nixpkgs { };
  lib = pkgs.lib;

  defaultFlakeJobset = {
    "enabled" = 1;
    "hidden" = false;
    "type" = 1; # make this a flake based jobset
    "description" = "A meaningful jobset description";
    "flake" = "nixpkgs#hello";
    "checkinterval" = 300;
    "schedulingshares" = 100;
    "enableemail" = false;
    # TODO find out why this must not be set
    #"enable_dynamic_run_command" = false;
    "emailoverride" = "";
    "keepnr" = 5;
  };


  flakeJobs = {
    a653rs = "github:dlr-ft/a653rs";
    a653rs-linux = "github:dlr-ft/a653rs-linux";
    a653rs-postcard = "github:dlr-ft/a653rs-postcard";
    a653rs-xng = "github:dlr-ft/a653rs-xng";
    seL4-nix-utils = "github:dlr-ft/seL4-nix-utils";
    sysml-v2-nix = "github:dlr-ft/sysml-v2-nix";

    apex-rs-vanilla = "github:aeronautical-informatics/apex-rs-vanilla";
    compcert-flake-utils = "github:aeronautical-informatics/compcert-flake-utils";
    openCAS = "github:aeronautical-informatics/openCAS";
    openTAWS = "github:aeronautical-informatics/openTAWS";
    qsma-parallel = "github:aeronautical-informatics/qsma-parallel";
    xng-flake-utils = "github:aeronautical-informatics/xng-flake-utils";
    xng-rs = "github:aeronautical-informatics/xng-rs";
  };

  jobs = lib.attrsets.mapAttrs
    (n: v: defaultFlakeJobset // {
      flake = v;
      description = "flake:${n}#hydraJobs";
    })
    flakeJobs;
in
{
  jobsets = pkgs.writeText "generated-jobset" (builtins.toJSON jobs);
}
