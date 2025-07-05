#Based on information at https://forums.ea.com/discussions/command-and-conquer-franchise-en/how-to-fix-problems-with-cc-generals-and-generals-zero-hour-on-windows-10/7204721


# Set path to the Options.ini file in the correct directory
$DocumentsPath = [Environment]::GetFolderPath('MyDocuments')
$OptionsIniPath = Join-Path $DocumentsPath "Command and Conquer Generals Zero Hour Data\Options.ini"

# Get the resolution of the primary monitor using WMI (Win32_VideoController)
$videoController = Get-CimInstance -ClassName Win32_VideoController | Select-Object -First 1

# Extract the resolution from the video controller object
$ResolutionWidth = $videoController.CurrentHorizontalResolution
$ResolutionHeight = $videoController.CurrentVerticalResolution

# Default settings for Options.ini
$settings = @"
AntiAliasing = 1
CampaignDifficulty = 0
DrawScrollAnchor = 
FirewallBehavior = 1
FirewallNeedToRefresh = FALSE
FirewallPortAllocationDelta = 0
Gamma = 50
IdealStaticGameLOD = Low
LanguageFilter = false
MoveScrollAnchor = 
MusicVolume = 0
Resolution = $ResolutionWidth $ResolutionHeight
Retaliation = yes
SFX3DVolume = 79
SFXVolume = 71
ScrollFactor = 16
SendDelay = no
StaticGameLOD = High
UseAlternateMouse = no
UseDoubleClickAttackMove = no
VoiceVolume = 70
"@

# Check if the Options.ini file exists
if (Test-Path $OptionsIniPath) {
    Write-Host "Options.ini already exists. Updating resolution..."
} else {
    Write-Host "Options.ini not found. Creating a new one..."
}

# Write the settings to the Options.ini file
$settings | Out-File -FilePath $OptionsIniPath -Encoding ASCII

Write-Host "Options.ini created or updated with resolution $ResolutionWidth x $ResolutionHeight."
