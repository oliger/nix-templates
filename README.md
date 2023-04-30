# Nix Templates

```sh
# Replace `node` with any templates in this repository.
nix flake init --template github:oliger/nix-templates#node
echo "use flake ." > .envrc
direnv allow
```
