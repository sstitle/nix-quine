{
  description = "Nix flake quine";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      apps.default = {
        type = "app";
        program = toString (
          nixpkgs.legacyPackages.${system}.writeShellScript "quine" ''
            cat ${
              builtins.path {
                path = ./flake.nix;
                name = "quine-source";
              }
            } \
              | ${nixpkgs.legacyPackages.${system}.nixfmt-rfc-style}/bin/nixfmt \
              | ${
                nixpkgs.legacyPackages.${system}.bat
              }/bin/bat --language=nix --style=plain --paging=never --color=always
          ''
        );
      };
      formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    });
}
