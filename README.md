# Windows Super-User Command

This PowerShell module provides a simple function to run any application or PowerShell command with administrative privileges from a non-administrative PowerShell.

Simply use the command alias `sudo`, followed by the application or PowerShell command to execute. Afterwards the UAC will ask you to grant administrative privileges to the new process and proceed with the action.

## Installation

1. Create a folder called `windows-sudo` at `C:\Program Files\WindowsPowerShell\modules`
2. Copy `windows-sudo.psd1` and `windows-sudo.psm1` into the folder `C:\Program Files\WindowsPowerShell\modules\windows-sudo`
3. Run the command `Import-Module windows-sudo`
4. Test the command by running `sudo write-error test`

If everything went fine, you should see the following output

```powershell
Invoke-AdminCall : test

...
bunch of errors
```

## Example 1

```powershell
sudo Restart-Service AudioSrv
```

## Example 2

```powershell
sudo Restart-Service AudioSrv -ErrorAction SilentlyContinue;
```

## Example 3

```powershell
sudo wt
```

## Example 4

```powershell
sudo powershell
```

## Example 5

```powershell
sudo 'C:\Program Files\obs-studio\bin\64bit\obs64.exe'
```
