# drzzln-lua-cli-template

template for lua cli programs

hello/ -- Project root directory
├── bin/ -- Executable scripts for CLI tools
│ └── hello.lua -- Main entry-point script for the CLI (executable)
├── src/ -- Lua source code (modules)
│ └── hello/ -- Module namespace (for internal logic, if any)
│ └── init.lua -- Main module (could also be split into multiple files)
├── spec/ -- Test files (using Busted framework)
│ └── hello.lua -- Example test specification for hello
├── hello-0.1-1.rockspec -- LuaRocks rockspec for the project (for distribution)
├── flake.nix -- Nix flake configuration (package, devShell, and CLI app)
└── README.md -- Project readme/documentation (optional, for users)
