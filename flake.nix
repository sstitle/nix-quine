{
  description = "Nix flake quine";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # The data part - flake source with placeholder
        data = ''{
  description = "Nix flake quine";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.''${system};

        # The data part - flake source with placeholder
        data = DATA;

        # The code part - builds the complete source
        source = builtins.replaceStrings ["DATA"] [(builtins.toJSON data)] data;

      in {
        apps.default = {
          type = "app";
          program = toString (pkgs.writeShellScript "quine" '''
            cat << 'QUINE_EOF'
''${source}QUINE_EOF
          ''');
        };
      }
    );
}
'';

        # The code part - builds the complete source
        source = builtins.replaceStrings ["DATA"] [(builtins.toJSON data)] data;

      in {
        apps.default = {
          type = "app";
          program = toString (pkgs.writeShellScript "quine" ''
            cat << 'QUINE_EOF'
${source}QUINE_EOF
          '');
        };
      }
    );
}
