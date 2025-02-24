## Install

- Windows
```pwsh
iex "&{$(irm 'https://get.chezmoi.io/ps1')} init --apply mechanicalbot"
```

- Linux/Mac
```sh
sh -c "$(wget -qO- get.chezmoi.io/lb)" -- init --apply mechanicalbot
```
```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply mechanicalbot
```
