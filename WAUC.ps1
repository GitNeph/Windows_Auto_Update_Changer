function Get-Funky{
    param([string]$Text)

    $Text.ToCharArray() | ForEach-Object{
        switch -Regex ($_){
            "`r"{
                break
            }
            "`n"{
                Write-Host " ";break
            }
            "[^ ]"{
                $writeHostOptions = @{
                    ForegroundColor = ([system.enum]::GetValues([System.ConsoleColor])) | Get-Random
                    #BackgroundColor = ([system.enum]::GetValues([System.ConsoleColor])) | Get-Random
                    NoNewLine = $true
                }
                Write-Host $_ @writeHostOptions
                break
            }
            " "{Write-Host " " -NoNewline}
        }
    }
}

$art = " .:::.   .:::.`n:::::::.:::::::`n:::::::::::::::
':::::::::::::'`n  ':::::::::'`n    ':::::'`n      ':'"


function Get-WAUCintro{
    For ($i = 0; $i -lt 10; $i++){
        Get-Funky $art
        Write-Host "`n"
        Start-Sleep -Milliseconds 500
        Clear-Host
        if ($i -eq 9){
            Get-Funky $art
            Write-Host "`n"
        }
    }
}

Get-WAUCintro

Clear-Host

Get-Content .\Title.txt
Write-Host "Windows-Automatic-Update-Changer v1.0 Copyright (C) 2020 Nephilim_AU [Brandon Pooler]`n"
Write-Host "This program comes with ABSOLUTELY NO WARRANTY;"
Write-Host "This is free software, and you are welcome to redistribute it.`n"

Write-Host "0: Change setting in Windows Update Service to allow a drop-down (default)`n"
Write-Host "1: Never check for updates. For those living on the edge.`n"
Write-Host "2: Notify for download & notify for install. All the nagging without any of the power. Just as it should be.`n"
Write-Host "3: Auto download & notify for install (Probably the best option for Ash)`n"
Write-Host "4: Auto download & Auto shedule install time. Because never knowing when it will happen keeps you on your toes.`n"

Write-Host "`nEnter any character that is not [0/1/2/3/4] to exit. I suggest the ENTER key personally."
Write-Host
switch(Read-Host "Choose Your Fate Mortal"){
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
