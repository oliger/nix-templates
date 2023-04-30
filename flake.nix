{
  description = "Nix Templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
  }:
    {
      templates = rec {
        deno = {
          path = ./deno;
          description = "Deno development environment";
        };

        go = {
          path = ./go;
          description = "Go development environment";
        };

        node = {
          path = ./node;
          description = "Node.js development environment";
        };

        rust = {
          path = ./rust;
          description = "Rust development environment";
        };

        zig = {
          path = ./zig;
          description = "Zig development environment";
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      inherit (pkgs) mkShell writeScriptBin;

      update = writeScriptBin "update" ''
        for dir in `ls -d */`; do
          (
            cd $dir
            nix flake update
            direnv reload
          )
        done
      '';
    in {
      formatter = pkgs.alejandra;

      devShells = {
        default = mkShell {
          packages = [update];
        };
      };
    });
}
