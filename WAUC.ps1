Clear-Host

Write-Host "0 -&gt; Change setting in Windows Update Service to allow a drop-down (default)"
Write-Host "1 -&gt; Never check for updates. For those living on the edge."
Write-Host "2 -&gt; Notify for download & notify for install. All the nagging without any of the power. Just as it should be."
Write-Host "3 -&gt; Auto download & notify for install (Probably the best option for Ash)"
Write-Host "4 -&gt; Auto download & Auto shedule install time. Because never knowing when it will happen keeps you on your toes."

Write-Host "Enter any character that is not [0/1/2/3/4] to exit. I suggest the ENTER key personally."
Write-Host
switch(Read-Host "Choose YOur Fate Mortal"){
    0 {$UpdateValue = 0}
    1 {$UpdateValue = 1}
    2 {$UpdateValue = 2}
    3 {$UpdateValue = 3}
    4 {$UpdateValue = 4}
    Default{Exit}
}

$WindowsUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\"
$AutoUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"

If (Test-Path -Path $WindowsUpdatePath) {
    Remove-Item -Path $WindowsUpdatePath -Recurse
}

If ($UpdateValue -gt 0) {
    New-Item -Path $WindowsUpdatePath
    New-Item -Path $AutoUpdatePath
}

If ($UpdateValue -eq 1) {
    Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 1
}
 
If ($UpdateValue -eq 2) {
    Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 0
    Set-ItemProperty -Path $AutoUpdatePath -Name AUOptions -Value 2
    Set-ItemProperty -Path $AutoUpdatePath -Name ScheduledInstallDay -Value 0
    Set-ItemProperty -Path $AutoUpdatePath -Name ScheduledInstallTime -Value 3
}
 
If ($UpdateValue -eq 3) {
    Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 0
    Set-ItemProperty -Path $AutoUpdatePath -Name AUOptions -Value 3
    Set-ItemProperty -Path $AutoUpdatePath -Name ScheduledInstallDay -Value 0
    Set-ItemProperty -Path $AutoUpdatePath -Name ScheduledInstallTime -Value 3
}
 
If ($UpdateValue -eq 4) {
    Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 0
    Set-ItemProperty -Path $AutoUpdatePath -Name AUOptions -Value 4
    Set-ItemProperty -Path $AutoUpdatePath -Name ScheduledInstallDay -Value 0
    Set-ItemProperty -Path $AutoUpdatePath -Name ScheduledInstallTime -Value 3
}