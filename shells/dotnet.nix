with import <nixpkgs> { };

mkShell {
  name = "dotnet";
  packages = [
    dotnet-sdk_10
    dotnet-ef
    nodejs
  ];
}
