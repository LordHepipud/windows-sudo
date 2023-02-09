function Start-AsAdmin()
{
    param (
        [string]$Application = $null
    );

    if ([string]::IsNullOrEmpty($Application)) {
        throw 'Please enter an application name, path or PowerShell Cmdlet';
    }

    if ($null -eq $args -Or $args.Count -ne 0) {
        $Arguments = [string]::Join(' ', $args);
    } else {
        $Arguments = $null;
    }

    $LogFile = New-TemporaryFile;

    if ($Application -ne 'powershell' -And (Test-Path $Application) -eq $FALSE -And (Get-Command $Application -ErrorAction SilentlyContinue)) {
        Start-Process 'powershell' -ArgumentList ([string]::Format('-Command &{{
            function Invoke-AdminCall {{
                try {{
                    {0} {1};
                }} catch {{
                    Write-Error $_;
                }}
            }}

            $UTF8NoBOM = New-Object System.Text.UTF8Encoding $FALSE;
            [console]::OutputEncoding = $UTF8NoBOM;

            Invoke-AdminCall 2>&1 | Tee-Object -FilePath {2};
        }}',
        $Application,
        $Arguments,
        $LogFile)) -Verb runAs -Wait -WindowStyle Hidden;

        $OutputFile = Get-Content -Path $LogFile -Raw -Encoding UTF8;

        if ([string]::IsNullOrEmpty($OutputFile) -eq $FALSE) {
            if ($OutputFile.Contains('~')) {
                Write-Host $OutputFile -ForegroundColor red;
            } else {
                Write-Host $OutputFile;
            }
        }
    } else {
        $ProcArgs = @{
            '-FilePath' = $Application;
            '-Verb'     = 'runAs';
            '-Wait'     = $TRUE;
            '-PassThru' = $TRUE;
        };

        if (Test-Path $Application) {
            $WorkDirectory = $Application.Substring(0, $Application.LastIndexOf('\'));
        }

        if ([string]::IsNullOrEmpty($Arguments) -eq $FALSE) {
            $ProcArgs.Add('-ArgumentList', $Arguments);
        }

        if ([string]::IsNullOrEmpty($WorkDirectory) -eq $FALSE) {
            $ProcArgs.Add('-WorkingDirectory', $WorkDirectory);
        }

        Start-Process @ProcArgs;
    }

    if (Test-Path $LogFile) {
        Remove-Item -Path $LogFile -Force;
    }
}

Set-Alias sudo Start-AsAdmin;
Export-ModuleMember -Function Start-AsAdmin -Alias sudo;
