{
  description = "Node.js development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [
        (self: super: rec {
          nodejs = super.nodejs_20;
          pnpm = super.nodePackages.pnpm;
          yarn = super.yarn.override {inherit nodejs;};
        })
      ];
      pkgs = import nixpkgs {inherit overlays system;};
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [nodejs pnpm yarn];

        shellHook = ''
          node --version
        '';
      };
    });
}
