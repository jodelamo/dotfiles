Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install Scoop
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
  Write-Host "Scoop already installed"
}

# Install packages
$packages = "$PSScriptRoot\scoopfile.txt"

if (-Not (Test-Path $packageFile)) {
  Write-Host "Error: Package file '$packageFile' not found."
  exit 1
}

foreach ($pkg in $packages) {
  if (-not (scoop list $pkg -q)) {
    scoop install $pkg
  } else {
    Write-Host "$pkg already installed"
  }
}
