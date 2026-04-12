#Requires -RunAsAdministrator
<#
.SYNOPSIS
  Install the Wazuh Windows agent from a local MSI (Lab 10 / mgmt).

.DESCRIPTION
  Run after install-wazuh-agent.ps1 has downloaded C:\wazuh-agent.msi, or set -MsiPath.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\install-wazuh-agent-msi.ps1
#>
param(
    [string]$MsiPath = 'C:\wazuh-agent.msi',
    [string]$WazuhManager = '172.16.200.10',
    [string]$RegistrationServer = '172.16.200.10',
    [string]$AgentGroup = 'default'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $MsiPath)) {
    throw "MSI not found: $MsiPath. Download it first (install-wazuh-agent.ps1) or pass -MsiPath."
}

$msiArgs = @(
    '/i', $MsiPath,
    '/q',
    "WAZUH_MANAGER=$WazuhManager",
    "WAZUH_REGISTRATION_SERVER=$RegistrationServer",
    "WAZUH_AGENT_GROUP=$AgentGroup"
)

Write-Host "Installing Wazuh agent from $MsiPath ..."
$p = Start-Process -FilePath 'msiexec.exe' -ArgumentList $msiArgs -Wait -PassThru
if ($p.ExitCode -notin 0, 3010) {
    throw "msiexec failed with exit code $($p.ExitCode). 3010 = success, reboot may be required."
}

Write-Host "Done. Start the service when ready: net start wazuh"
