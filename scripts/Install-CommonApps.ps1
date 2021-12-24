<#
.SYNOPSIS
Install Common Windows Apps

.DESCRIPTION
This script installs and/or upgrades the common Windows Apps

.EXAMPLE
.\Install-CommonApps.ps1
#>

$packages = @(
    "7zip"
    "googlechrome"
    "python"
    "sysinternals"
    "vlc"
    "vscode"
)

# Set cache path
$cachePath = Set-TempDirectory
# Install common packages that everyone should have
echo "Installing Packages"
choco upgrade -cache $cachePath -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
$packages | %{choco upgrade -cache $cachePath -y $_ --force -y}
