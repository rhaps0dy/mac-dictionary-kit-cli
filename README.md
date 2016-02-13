# mac-dictionary-kit-cli
CLI version of mac-dictionary-kit.

## Why?
The mentioned program gets stuck on my machine with input files of ~3MB. Plus,
the UI annoys me, I dislike dragging files.

## Usage
```sh
git clone --recursive https://github.com/rhaps0dy/mac-dictionary-kit-cli.git
cd mac-dictionary-kit-cli
make
```

Now you can use the `convert.sh` file. Its usage is
`./convert.sh [-h/--help] <file.ifo> [dictionary\_name]`. Run it without
arguments or with -h or --help for more details.
