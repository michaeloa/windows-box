function Set-TempDirectory {
    <#
    .SYNOPSIS
    Ensures that a c:\temp directory exists

    .DESCRIPTION
    Creates a c:\temp directory. Found that having this present is useful when running chocolatey scripts.

    #>
    $tempPath = "c:\temp\"
    If(!(test-path $tempPath))
    {
        New-Item -ItemType Directory -Force -Path $tempPath
    }
    return $tempPath
}
