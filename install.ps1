if (Test-Path (Get-Command nvim.exe).Path) {
    Copy-Item -Path '.\nvim' -Destination $Env:LocalAppData -Recurse
}