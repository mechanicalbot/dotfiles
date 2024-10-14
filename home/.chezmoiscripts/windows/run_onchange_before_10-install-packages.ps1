Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

Write-Host 'Install packages...' -ForegroundColor Green

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

Write-Host 'Install packages via scoop' -ForegroundColor Green
$scoopPackages = @(
    'main/7zip',
    'extras/age',
    'nerd-fonts/FiraCode-NF-Mono',
    'main/flyctl',
    'main/gpg',
    'main/helm',
    'main/kubectl',
    'main/openssl',
    'extras/snipaste',
    'main/sops',
    'main/starship',
    'main/wrangler'
)
Invoke-Expression "scoop install $scoopPackages"

Write-Host 'Install packages via winget' -ForegroundColor Green
$wingetPackages = @(
    'Brave.Brave',
    'Google.Chrome',
    'Mozilla.Firefox',
    'Git.Git',
    'GitHub.cli',
    'Axosoft.GitKraken',
    'Docker.DockerDesktop',
    'Microsoft.PowerShell',
    'Microsoft.PowerToys',
    'Microsoft.VisualStudioCode',
    'Microsoft.WindowsTerminal'
    'Neovim.Neovim',
    'Mirantis.Lens',
    'Postman.Postman',
    'Deezer.Deezer',
    'Notion.Notion',
    'Obsidian.Obsidian',
    'Telegram.TelegramDesktop',
    'JAMSoftware.TreeSize.Free'
    'Google.ChromeRemoteDesktopHost',
    'Google.GoogleDrive',
    'Discord.Discord',
    'FACEITLTD.FACEITAC',
    'Valve.Steam',
    'EpicGames.EpicGamesLauncher',
    'GOG.Galaxy',
    'PlayStation.PSRemotePlay',
    'SideQuestVR.SideQuest',
    'Valve.SteamLink',
    'VirtualDesktop.Streamer',
    'qBittorrent.qBittorrent'
)
$wingetSnapshot = @{
    '$schema' = "https://aka.ms/winget-packages.schema.2.0.json"
    'Sources' = @(
        @{
            "Packages" = @(
                foreach ($package in $wingetPackages) {
                    @{
                        PackageIdentifier = $package
                    }
                }
            )
            "SourceDetails" = @{
                "Argument"   = "https://cdn.winget.microsoft.com/cache"
                "Identifier" = "Microsoft.Winget.Source_8wekyb3d8bbwe"
                "Name"       = "winget"
                "Type"       = "Microsoft.PreIndexed.Package"
            }
        }
    )
}
$wingetSnapshotTemp = $(Get-Item ([System.IO.Path]::GetTempFilename())).FullName
Set-Content -Path $wingetSnapshotTemp -Value $($wingetSnapshot | ConvertTo-Json -Depth 4)
winget import -i $wingetSnapshotTemp --accept-package-agreements --accept-source-agreements --disable-interactivity
Remove-Item -Path $wingetSnapshotTemp -Force

# Read-Host "Press any key to continue"
# Stop-Process -Id $PID
