{
  description = "asdf-ghjk: asdf version manager plugin for ghjk";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Build inputs for development
        buildInputs = with pkgs; [
          bash
          curl
          gnutar
          gnugrep
          coreutils
          git
        ];

        # Development tools
        devInputs = with pkgs; [
          shellcheck
          shfmt
          bats
          just
          gnumake
        ];

        # Runtime dependencies for ghjk
        runtimeDeps = with pkgs; [
          git
          curl
          gnutar
          unzip
          zstd
        ];

      in
      {
        # Development shell
        devShells.default = pkgs.mkShell {
          buildInputs = buildInputs ++ devInputs ++ runtimeDeps;

          shellHook = ''
            echo "🚀 asdf-ghjk development environment"
            echo "===================================="
            echo ""
            echo "Available commands:"
            echo "  just --list    - Show all available tasks"
            echo "  just setup     - Set up development environment"
            echo "  just test      - Run tests"
            echo "  just lint      - Run linting"
            echo "  just check     - Run all checks"
            echo ""
            echo "Tools available:"
            echo "  bash:       $(bash --version | head -1)"
            echo "  shellcheck: $(shellcheck --version | head -2 | tail -1)"
            echo "  just:       $(just --version)"
            echo ""
          '';
        };

        # Package for the plugin itself
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "asdf-ghjk";
          version = "0.1.0";

          src = ./.;

          buildInputs = buildInputs;

          dontBuild = true;

          installPhase = ''
            mkdir -p $out
            cp -r bin $out/
            cp -r lib $out/
            cp README.md LICENSE.txt $out/
            cp -r docs $out/ || true
          '';

          meta = with pkgs.lib; {
            description = "asdf version manager plugin for ghjk";
            homepage = "https://github.com/Hyperpolymath/asdf-ghjk";
            license = with licenses; [ mit ];
            platforms = platforms.unix;
            maintainers = [ ];
          };
        };

        # Checks (tests and linting)
        checks = {
          # ShellCheck linting
          shellcheck = pkgs.runCommand "shellcheck" {
            buildInputs = [ pkgs.shellcheck ];
          } ''
            cd ${./.}
            shellcheck bin/* lib/*.sh scripts/*.sh
            touch $out
          '';

          # BATS tests
          tests = pkgs.runCommand "bats-tests" {
            buildInputs = [ pkgs.bats ] ++ buildInputs;
          } ''
            cd ${./.}
            # Install BATS if needed
            if [ ! -d test/bats ]; then
              git clone --depth 1 https://github.com/bats-core/bats-core.git test/bats
            fi
            # Run tests
            ./test/bats/bin/bats test/*.bats
            touch $out
          '';
        };

        # Apps (runnable commands)
        apps = {
          # List all available versions
          list-all = {
            type = "app";
            program = "${self.packages.${system}.default}/bin/list-all";
          };
        };

        # Formatter
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
