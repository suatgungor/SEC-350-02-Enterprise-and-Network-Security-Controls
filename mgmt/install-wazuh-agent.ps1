<#
.SYNOPSIS
  Download the Wazuh Windows agent MSI (Lab 10 / mgmt).

.DESCRIPTION
  Pull this repo on the mgmt VM, then run:
    powershell -ExecutionPolicy Bypass -File .\install-wazuh-agent.ps1

  Install and start the service yourself, for example:
    msiexec.exe /i C:\wazuh-agent.msi /q WAZUH_MANAGER="172.16.200.10" WAZUH_REGISTRATION_SERVER="172.16.200.10" WAZUH_AGENT_GROUP="default"
    net start wazuh
#>
param(
    [string]$MsiUrl = 'https://packages.wazuh.com/4.x/windows/wazuh-agent-4.3.11-1.msi',
    [string]$OutPath = 'C:\wazuh-agent.msi'
)

$ErrorActionPreference = 'Stop'

Write-Host "Downloading Wazuh agent MSI to $OutPath ..."
Invoke-WebRequest -Uri $MsiUrl -OutFile $OutPath -UseBasicParsing
Write-Host "Done. Run install and start the Wazuh service when you are ready."
