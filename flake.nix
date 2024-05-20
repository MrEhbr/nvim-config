{
  description = "A Nix-flake-based Lua development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";

  nixConfig = {
    substituters = [
      # high priority since it's almost always used
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    { self
    , nixpkgs
    ,
    }:
    let
      goVersion = 21;
      overlays = [
        (final: prev: {
          go = prev."go_1_${toString goVersion}";
          gofumpt = prev.gofumpt.overrideAttrs { version = "0.5.0"; };
        })
      ];
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system:
          f {
            pkgs = import nixpkgs { inherit overlays system; };
          });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # Lua
            stylua
            lua-language-server
          ];
        };
      });
    };
}
