$ErrorActionPreference = "Stop"

Write-Host 'Install scoop' -ForegroundColor Green
if ($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) 
{
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}
