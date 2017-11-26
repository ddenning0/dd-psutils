# dd-psutils
I use Powershell a lot in my day job.

## Usage
1.  Dot source the files you want. If script execution is restricted then I feel sorry for you. Stick it to the man and pipe the file contents into the Invoke-Expression cmdlet instead:
```
Get-Content filename.ps1 | Out-String | Invoke-Expression
```
2.  Use them. See each function's Get-Help for more information.