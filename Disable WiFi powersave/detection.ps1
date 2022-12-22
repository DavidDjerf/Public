# Detection
# 2022-05-22 - David Djerf - Initial version
# 2022-05-25 - David Djerf - Added support for device powersave 

$NetAdapter = Get-NetAdapter | Where-Object InterfaceType -eq 71

If ( ($NetAdapter | measure).Count -ge 1) {

    If ((Get-NetAdapterAdvancedProperty -Name $NetAdapter.Name -DisplayName "MIMO Power Save Mode").DisplayValue -like "No SMPS") {
        $MIMO = $true
    } Else {
        $MIMO = $false
    }

    $NetAdapterPowerManagement = $NetAdapter | Get-NetAdapterPowerManagement
    If ($NetAdapterPowerManagement.AllowComputerToTurnOffDevice -eq 'Disabled') {
        $DEVICE = $true
    } Else {
        $DEVICE = $false
    }

    IF ($MIMO -and $DEVICE) {
        Return $True
    } Else {
        Return $False
    }

} Else {
    Return $True
}
