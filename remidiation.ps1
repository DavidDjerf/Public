# Remidiate
# Script to disable Wifi powersave features
# 2022-05-22 - David Djerf - Initial version
# 2022-05-25 - David Djerf - Added support for wifi device powersave

# Find Wifi adapter
$NetAdapter = Get-NetAdapter | Where-Object InterfaceType -eq 71
# Get-NetAdapterAdvancedProperty $NetAdapter.Name

# Get Power management settings
$NetAdapterPowerManagement = $NetAdapter | Get-NetAdapterPowerManagement

#Enable
<#
If ( ($NetAdapter | Measure ).Count -ge 1) {
    Set-NetAdapterAdvancedProperty -Name $NetAdapter.Name -DisplayName "MIMO Power Save Mode" -DisplayValue "Auto SMPS"
}
#>

#Disable
If ( ($NetAdapter | Measure).Count -ge 1) {
    # MIMO power saving
	Set-NetAdapterAdvancedProperty -Name $NetAdapter.Name -DisplayName "MIMO Power Save Mode" -DisplayValue "No SMPS"
    # Wifi device powersave
	$NetAdapterPowerManagement.AllowComputerToTurnOffDevice = 'Disabled'
    $NetAdapterPowerManagement | Set-NetAdapterPowerManagement
} 
