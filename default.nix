{ nixpkgs }: let pkgs = import nixpkgs {}; in {
  master = pkgs.runCommand "spec.json" {} ''
    cat > $out <<EOF
    {
        "enabled": 1,
        "hidden": false,
        "description": "js",
        "nixexprinput": "src",
        "nixexprpath": "release.nix",
        "checkinterval": 300,
        "schedulingshares": 100,
        "enableemail": false,
        "keepnr": 3,
        "inputs": {
            "src": { "type": "git", "value": "git://github.com/shlevy/declarative-hydra-example.git", "emailresponsible": false },
            "nixpkgs": { "type": "git", "value": "git://github.com/NixOS/nixpkgs.git release-16.03", "emailresponsible": false }
        }
    }

    EOF
  '';
}

