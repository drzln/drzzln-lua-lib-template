# flake.nix
{
  description = "Lua CLI project with reusable rockspec-based builder";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    lua = pkgs.lua5_4;
    luaPkgs = pkgs.lua54Packages;
    buildLuaFromRockspec = {
      pname,
      version,
      # rockspec,
      src,
      lua,
      luaPkgs,
    }:
      pkgs.stdenv.mkDerivation {
        inherit pname version src;
        buildInputs = [lua luaPkgs.argparse];
        installPhase = ''
          echo "[+] Installing bin scripts..."
          mkdir -p $out/bin
          cp bin/*.lua $out/bin/
          chmod +x $out/bin/*
          echo "[+] Installing Lua modules..."
          mkdir -p $out/share/lua/5.4
          find src -type f -name '*.lua' -exec cp --parents {} $out/share/lua/5.4/ \;
        '';
        dontWrapLua = true;
        LUA_PATH = "$out/share/lua/5.4/?.lua;$out/share/lua/5.4/?/init.lua;${luaPkgs.argparse}/share/lua/5.4/?.lua;;";
      };
  in {
    packages.${system}.default = buildLuaFromRockspec {
      pname = "hello";
      version = "0.1.0";
      rockspec = ./hello-0.1-1.rockspec;
      src = ./.;
      inherit lua luaPkgs;
    };
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        lua
        pkgs.luarocks
        luaPkgs.argparse
        luaPkgs.busted
      ];
      shellHook = ''
        export LUA_PATH="${luaPkgs.argparse}/share/lua/5.4/?.lua;${luaPkgs.argparse}/share/lua/5.4/?/init.lua;;"
        export LUA_CPATH="${luaPkgs.argparse}/lib/lua/5.4/?.so;;"
        eval "$(luarocks path --lua-version=5.4)"
      '';
    };
  };
}
