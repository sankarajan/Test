
$workdir = "D:\installer\"
# Check if work directory exists if not create it
If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }
# Download the installer
$source = "https://storageaccount4321.blob.core.windows.net/testsoftware/PowerISO7.exe"
$destination = "$workdir\PowerISO7.exe"
# Check if Invoke-Webrequest exists otherwise execute WebClient
if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}
Invoke-WebRequest $source -OutFile $destination 
# Start the installation
start-process "$workdir\PowerISO7.exe" /S  
# Wait XX Seconds for the installation to finish
Start-Sleep -s 35
# Remove the installer
rm -Force $workdir\7*
 