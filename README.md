# Windows_Auto_Update_Changer
A CLI tool that allows a user to configure the Windows auto update to their whim.

## Instructions
1. Download this repository as a zip folder
2. Place it in your `C:\` directory
3. Hit your `Windows Key` & type `Powershell`
4. Right-click the `Windows PowerShell` application & select `Run as Administrator`
5. Copy the below code as a single block & paste it into the Powershell terminal. Hit Enter

```Powershell
$env:Path += ";C:\Windows_Auto_Update_Changer"
Set-ExecutionPolicy Unrestricted
C:\Windows_Auto_Update_Changer\WAUC.ps1
```
6. The CLI application will walk you the rest of the way through.
7. Once you have completed configuring your Automatic Updates settings copy the code below as one block like before  & paste it into the PowerShell Terminal

```Powershell
Set-ExecutionPolicy Default
Exit-PSSession
```

