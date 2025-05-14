# flake.nix
# flake.nix
{
  description = "Lua library project with reusable rockspec-based builder";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    lua = pkgs.lua5_4;
    luaPkgs = pkgs.lua54Packages;

    buildLuaLibraryFromRockspec = {
      pname,
      version,
      src,
      lua,
    }:
      pkgs.stdenv.mkDerivation {
        inherit pname version src;
        buildInputs = [lua];

        installPhase = ''
          echo "[+] Installing Lua modules..."
          mkdir -p $out/share/lua/5.4
          find src -type f -name '*.lua' -exec cp --parents {} $out/share/lua/5.4/ \;
        '';

        LUA_PATH = "$out/share/lua/5.4/?.lua;$out/share/lua/5.4/?/init.lua;;";
      };
  in {
    packages.${system}.default = buildLuaLibraryFromRockspec {
      pname = "hellolib";
      version = "0.1.0";
      src = ./.;
      inherit lua luaPkgs;
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        lua
        pkgs.luarocks
        luaPkgs.busted
      ];
      shellHook = ''
        export LUA_PATH="./src/?.lua;./src/?/init.lua;;"
        eval "$(luarocks path --lua-version=5.4)"
        echo "Dev shell for Lua library ready. Use 'lua' or 'busted'"
      '';
    };
  };
}
