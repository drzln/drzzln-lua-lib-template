-- mytool-0.1-1.rockspec
rockspec_format = "3.0" -- Using latest rockspec format for more features:contentReference[oaicite:4]{index=4}
package = "hello" -- Package name
version = "0.1-1" -- Version (0.1, revision 1)
summary = "A sample CLI tool that greets and repeats words."
description = [[
Mytool is a command-line tool written in Lua that demonstrates argument parsing, 
subcommands, and distribution via LuaRocks. It can greet users and repeat words.
]]
homepage = "https://example.com/mytool" -- (Example URL, replace with actual repo or homepage)
license = "MIT" -- License
maintainer = "Your Name <you@example.com>"

source = {
	url = "git+https://github.com/yourname/mytool.git",
	tag = "v0.1", -- assuming v0.1 tag in git corresponds to this release
}

dependencies = {
	"lua >= 5.3, < 5.5", -- Requires Lua 5.3 or 5.4 (LuaJIT is 5.1-compatible and can be used as well)
	"argparse >= 0.7", -- CLI argument parser library:contentReference[oaicite:5]{index=5}
	-- (Note: We don't list 'busted' here, as it's only needed for development/testing)
}

build = {
	type = "builtin", -- Use the built-in LuaRocks build (simple install)
	modules = {
		["hello"] = "src/hello/init.lua", -- Install the mytool module (if any) into Lua path:contentReference[oaicite:6]{index=6}
	},
	bin = {
		["hello"] = "bin/hello.lua", -- Install the CLI script as an executable named "mytool"
	},
}
