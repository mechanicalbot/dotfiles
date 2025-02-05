## Install

- Windows
```pwsh
iex "&{$(irm 'https://get.chezmoi.io/ps1')} init --apply mechanicalbot"
```

- Linux
```sh
sh -c "$(wget -qO- get.chezmoi.io)" -- init --apply mechanicalbot
```

- Mac
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mechanicalbot
```
