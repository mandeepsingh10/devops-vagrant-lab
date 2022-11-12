$version = "0.16.0"

$AgentURL = "https://github.com/prometheus-community/windows_exporter/releases/download/v${version}/windows_exporter-${version}-386.msi"
$AbsoluteCurrPath = $(Get-Location).Path
$AbsolutePathMSI = "${AbsoluteCurrPath}\tmp\windows-exporter\windows_exporter.msi"
$EnabledCollectors = "[defaults],cpu,cs,logical_disk,memory,net,os,process,service,system,tcp"
$ServiceName = "windows_exporter"
$TempDirectoryToCreate =  "$AbsoluteCurrPath\tmp\windows-exporter"

# create temp directories
if (-not (Test-Path -LiteralPath $TempDirectoryToCreate)) {
    try {
        New-Item -Path $TempDirectoryToCreate -ItemType Directory -ErrorAction Stop | Out-Null #-Force
    } catch {
        Write-Error -Message "Unable to create directory '$TempDirectoryToCreate'. Error was: $_" -ErrorAction Stop
    }
    "Successfully created directory '$TempDirectoryToCreate'."
} else {
    "Directory already existed"
}

# download specify msi to temp directory
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $AgentURL -OutFile $AbsolutePathMSI
# Start-Process msiexec -Wait -ArgumentList "/i ${AbsolutePathMSI} ENABLED_COLLECTORS=$EnabledCollectors"
(Start-Process "msiexec.exe" -ArgumentList "/i ${AbsolutePathMSI} ENABLED_COLLECTORS=$EnabledCollectors /qb!" -NoNewWindow -Wait -PassThru).ExitCode

# Check Status of Service
$Service = Get-Service -Name "$ServiceName"
if($Service.Status -eq "running"){
  Write-Host "$ServiceName is running"  
} else {
    Write-Host "$ServiceName status is: $Service.Status"
}
# remove temp setup file
if(Test-Path $AbsoluteCurrPath\tmp\windows-exporter -PathType Container){
    Remove-Item -Recurse -Force $AbsoluteCurrPath\tmp\windows-exporter
} else {
    Write-Host "TMP path not available"  
}
 
