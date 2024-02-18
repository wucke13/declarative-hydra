{ nixpkgs, declInput }:
let
  pkgs = import nixpkgs { };

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

  flakes = [
    "github:dlr-ft/a653rs"
    "github:dlr-ft/a653rs-linux"
    "github:dlr-ft/a653rs-postcard"
    "github:dlr-ft/a653rs-xng"
    "github:dlr-ft/seL4-nix-utils"
    "github:dlr-ft/sysml-v2-nix"

    "github:aeronautical-informatics/apex-rs-vanilla"
    "github:aeronautical-informatics/compcert-flake-utils"
    "github:aeronautical-informatics/openCAS"
    "github:aeronautical-informatics/openTAWS"
    "github:aeronautical-informatics/qsma-parallel"
    "github:aeronautical-informatics/xng-flake-utils"
    "github:aeronautical-informatics/xng-rs"
  ];

  jobs = builtins.listToAttrs (builtins.map
    (flakeUrl: {
      name = pkgs.lib.strings.replaceStrings [ "/" ":" "?" ] [ " " " " " " ] flakeUrl;
      value = defaultFlakeJobset // { flake = flakeUrl; };
    })
    flakes);
in
{
  jobsets = pkgs.writeText "generated-jobset" (builtins.toJSON jobs);
}
