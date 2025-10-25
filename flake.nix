{
  description = "Nix flake quine";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system: {
    apps.default = {
      type = "app";
      program = toString (
        nixpkgs.legacyPackages.${system}.writeShellScript "quine" ''
          cat ${builtins.path { path = ./flake.nix; name = "quine-source"; }}
        ''
      );
    };
  });
}
