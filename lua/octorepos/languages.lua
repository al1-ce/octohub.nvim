local M = {}

M.language_to_filetype = function(language)
    if language == vim.NIL then
        return 'md'
    end

    local map = {
        ['APL'] = 'apl',
        ['ASP.NET'] = 'aspx',
        ['AVIF'] = 'avif',
        ['AWK'] = 'awk',
        ['ActionScript'] = 'as',
        ['Ada'] = 'ada',
        ['Apex'] = 'cls',
        ['Arduino'] = 'ino',
        ['Assembly'] = 'asm',
        ['AutoHotkey'] = 'ahk',
        ['BMP'] = 'bmp',
        ['BQN'] = 'bqn',
        ['Bash'] = 'bash',
        ['Batchfile'] = 'bat',
        ['Bazel'] = 'bzl',
        ['BibTeX'] = 'bib',
        ['Bicep Parameters'] = 'bicepparam',
        ['Bicep'] = 'bicep',
        ['Blueprint'] = 'blp',
        ['Brewfile'] = 'brewfile',
        ['C#'] = 'cs',
        ['C'] = 'c',
        ['C++'] = 'cpp',
        ['CMake'] = 'cmake',
        ['COBOL'] = 'cobol',
        ['CSON'] = 'cson',
        ['CSS'] = 'css',
        ['CSV'] = 'csv',
        ['CUDA'] = 'cu',
        ['Clojure'] = 'clj',
        ['CoffeeScript'] = 'coffee',
        ['Configuration'] = 'cfg',
        ['Copying'] = 'copying',
        ['Crystal'] = 'cr',
        ['D'] = 'd',
        ['DOT'] = 'dot',
        ['Dart'] = 'dart',
        ['Desktop Entry'] = 'desktop',
        ['Diff'] = 'diff',
        ['Dockerfile'] = 'dockerfile',
        ['Drools'] = 'drl',
        ['Dropbox'] = 'dropbox',
        ['Dump'] = 'dump',
        ['EEx'] = 'eex',
        ['EJS'] = 'ejs',
        ['ERuby'] = 'erb',
        ['Elixir'] = 'ex',
        ['Elm'] = 'elm',
        ['Embedded Puppet'] = 'epp',
        ['Erlang'] = 'erl',
        ['F# Script File'] = 'fsscript',
        ['F# Script'] = 'fsi',
        ['F# Script'] = 'fsx',
        ['F#'] = 'fs',
        ['Fennel'] = 'fnl',
        ['Fish'] = 'fish',
        ['Forth'] = 'fs',
        ['Fortran'] = 'f90',
        ['GDScript'] = 'gd',
        ['GIF'] = 'gif',
        ['GLB'] = 'glb',
        ['GQL'] = 'gql',
        ['GTK RC'] = 'gtkrc',
        ['Gemfile'] = 'gemfile$',
        ['Gettext Catalog'] = 'po',
        ['Git Attributes'] = '.gitattributes',
        ['Git Commit'] = 'commit_editmsg',
        ['Git Config'] = '.gitconfig',
        ['Git Ignore'] = '.gitignore',
        ['Git'] = 'git',
        ['Go'] = 'go',
        ['Godot Resource'] = 'tres',
        ['Godot Scene'] = 'tscn',
        ['Godot'] = 'godot',
        ['GraphQL'] = 'graphql',
        ['Groovy'] = 'groovy',
        ['Gruntfile'] = 'gruntfile',
        ['Gulpfile'] = 'gulpfile',
        ['HAML'] = 'haml',
        ['HEEx'] = 'heex',
        ['HTML'] = 'html',
        ['Handlebars'] = 'hbs',
        ['Haskell'] = 'hs',
        ['Haxe'] = 'hx',
        ['Hex'] = 'hex',
        ['ICO'] = 'ico',
        ['IDL'] = 'pro',
        ['Idris'] = 'idr',
        ['Import'] = 'import',
        ['JPEG'] = 'jpeg',
        ['JPG'] = 'jpg',
        ['JSON'] = 'json',
        ['JSON5'] = 'json5',
        ['JSONC'] = 'jsonc',
        ['JSX'] = 'jsx',
        ['Java'] = 'java',
        ['JavaScript'] = 'js',
        ['Julia'] = 'jl',
        ['Jupyter Notebook'] = 'ipynb',
        ['Kotlin'] = 'kt',
        ['LEEx'] = 'leex',
        ['LaTeX'] = 'tex',
        ['Less'] = 'less',
        ['Lesser Copying'] = 'copying.lesser',
        ['License'] = 'license',
        ['Liquid'] = 'liquid',
        ['Literate Haskell'] = 'lhs',
        ['Literate Prolog'] = 'sig',
        ['Lock'] = 'lock',
        ['Log'] = 'log',
        ['Lua'] = 'lua',
        ['MATLAB'] = 'm',
        ['MDX'] = 'mdx',
        ['Makefile'] = 'makefile',
        ['Markdown'] = 'md',
        ['Material'] = 'material',
        ['Microsoft Excel (OOXML)'] = 'xlsx',
        ['Microsoft Excel'] = 'xls',
        ['Microsoft PowerPoint'] = 'ppt',
        ['Microsoft Word (OOXML)'] = 'docx',
        ['Microsoft Word'] = 'doc',
        ['Mint'] = 'mint',
        ['Motoko'] = 'mo',
        ['Mustache'] = 'mustache',
        ['Neovim Checkhealth'] = 'checkhealth',
        ['Nim'] = 'nim',
        ['Nix'] = 'nix',
        ['Node.js'] = 'node_modules',
        ['Nu'] = 'nu',
        ['OBJ'] = 'obj',
        ['OCaml'] = 'ml',
        ['OTF'] = 'otf',
        ['Objective-C'] = 'm',
        ['OpenSCAD'] = 'scad',
        ['Opus'] = 'opus',
        ['PCK'] = 'pck',
        ['PDF'] = 'pdf',
        ['PHP'] = 'php',
        ['PNG'] = 'png',
        ['PSB'] = 'psb',
        ['PSD'] = 'psd',
        ['Perl'] = 'pl',
        ['PlainTeX'] = 'tex',
        ['PostScript'] = 'ai',
        ['PowerShell Data'] = 'psd1',
        ['PowerShell Module'] = 'psm1',
        ['PowerShell'] = 'ps1',
        ['Prisma'] = 'prisma',
        ['Procfile'] = 'procfile',
        ['Prolog'] = 'pro',
        ['Puppet'] = 'pp',
        ['PureScript'] = 'purs',
        ['Python Bytecode'] = 'pyc',
        ['Python Extension Module'] = 'pyd',
        ['Python Optimized Bytecode'] = 'pyo',
        ['Python'] = 'py',
        ['Query'] = 'query',
        ['R Markdown'] = 'rmd',
        ['R Project'] = 'rproj',
        ['R'] = 'r',
        ['RLIB'] = 'rlib',
        ['Racket'] = 'rkt',
        ['ReScript'] = 'res',
        ['Ruby'] = 'rb',
        ['Rust'] = 'rs',
        ['SBT'] = 'sbt',
        ['SCSS'] = 'scss',
        ['SQL'] = 'sql',
        ['SQLite'] = 'sqlite',
        ['SQLite3'] = 'sqlite3',
        ['SVG'] = 'svg',
        ['Sass'] = 'sass',
        ['Scala'] = 'scala',
        ['Scheme'] = 'scm',
        ['Shell'] = 'sh',
        ['Solidity'] = 'sol',
        ['Solution'] = 'sln',
        ['Standard ML'] = 'sml',
        ['Stylus'] = 'styl',
        ['SubRip Subtitle'] = 'srt',
        ['SubStation Alpha'] = 'ssa',
        ['Sublime Text'] = 'sublime',
        ['Svelte'] = 'svelte',
        ['Swift Playground'] = 'xcplayground',
        ['Swift'] = 'swift',
        ['SystemVerilog'] = 'sv',
        ['TADS'] = 't',
        ['TOML'] = 'toml',
        ['Templ'] = 'templ',
        ['Terminal'] = 'terminal',
        ['Text'] = 'txt',
        ['Twig'] = 'twig',
        ['TypeScript React'] = 'tsx',
        ['TypeScript'] = 'ts',
        ['Unlicense'] = 'unlicense',
        ['VHDL'] = 'vhd',
        ['Vagrantfile'] = 'vagrantfile$',
        ['Vala'] = 'vala',
        ['Verilog'] = 'v',
        ['Visual Basic .NET'] = 'vb',
        ['Visual Studio Solution User Options'] = 'suo',
        ['Vue'] = 'vue',
        ['WebAssembly'] = 'wasm',
        ['WebM'] = 'webm',
        ['WebP'] = 'webp',
        ['Webpack'] = 'webpack',
        ['XML'] = 'xml',
        ['YAML'] = 'yaml',
        ['Zig'] = 'zig',
        ['Zsh'] = 'zsh',
    }

    return map[language] or language:lower()
end

return M
