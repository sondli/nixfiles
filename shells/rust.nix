with import <nixpkgs> { };

mkShell {
  name = "rust";
  packages = [
    rustc
    cargo
    rustfmt
    gdb
  ];
}
