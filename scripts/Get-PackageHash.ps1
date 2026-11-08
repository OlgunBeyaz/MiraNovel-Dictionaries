param(
    [Parameter(Mandatory=$true)]
    [string]$Path
)

if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    throw "File not found: $Path"
}

$file = Get-Item -LiteralPath $Path
$hash = Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256
[pscustomobject]@{
    FileName = $file.Name
    SizeBytes = $file.Length
    SHA256 = $hash.Hash.ToLowerInvariant()
} | Format-List
