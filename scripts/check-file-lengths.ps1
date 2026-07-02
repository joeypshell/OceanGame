param(
	[int]$TargetMaxLines = 499,
	[int]$RefactorThresholdLines = 1000,
	[switch]$FailOnRefactorThreshold,
	[switch]$FailOnWarning
)

$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

$includedExtensions = @(
	".gd",
	".ps1",
	".mjs",
	".js",
	".ts",
	".md"
)

$excludedDirectories = @(
	".git",
	".godot",
	".import",
	"addons",
	"builds",
	"exports",
	"node_modules",
	"vendor",
	"test-results",
	"playwright-report",
	"playwright-report-area01-shell"
)

$excludedPathPrefixes = @(
	"docs/archive"
)

function Test-IsExcludedPath {
	param([string]$RelativePath)

	$normalizedPath = $RelativePath -replace '\\', '/'
	foreach ($prefix in $excludedPathPrefixes) {
		if ($normalizedPath -eq $prefix -or $normalizedPath.StartsWith("$prefix/")) {
			return $true
		}
	}

	$parts = $RelativePath -split '[\\/]'
	foreach ($part in $parts) {
		if ($excludedDirectories -contains $part) {
			return $true
		}
	}
	if ($RelativePath.EndsWith(".import")) {
		return $true
	}
	if ($RelativePath -match '\.generated\.') {
		return $true
	}
	return $false
}

function Get-LineCount {
	param([string]$Path)

	return ([System.IO.File]::ReadAllLines($Path)).Count
}

function Get-RelativeRepoPath {
	param([string]$Path)

	$root = $repoRoot.Path.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
	$fullPath = [System.IO.Path]::GetFullPath($Path)
	if ($fullPath.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
		return $fullPath.Substring($root.Length).TrimStart([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
	}
	return $Path
}

$results = @()
Get-ChildItem -Path $repoRoot -Recurse -File |
	Where-Object { $includedExtensions -contains $_.Extension.ToLowerInvariant() } |
	ForEach-Object {
		$relativePath = Get-RelativeRepoPath $_.FullName
		if (-not (Test-IsExcludedPath $relativePath)) {
			$lineCount = Get-LineCount $_.FullName
			$status = "OK"
			if ($lineCount -gt $RefactorThresholdLines) {
				$status = "REFACTOR"
			}
			elseif ($lineCount -gt $TargetMaxLines) {
				$status = "WARNING"
			}

			$results += [pscustomobject]@{
				Path = $relativePath
				Lines = $lineCount
				Status = $status
			}
		}
	}

$sortedResults = $results | Sort-Object -Property @{Expression = "Lines"; Descending = $true}, @{Expression = "Path"; Descending = $false}
$sortedResults | Format-Table -AutoSize

$warningCount = @($results | Where-Object { $_.Lines -gt $TargetMaxLines }).Count
$refactorCount = @($results | Where-Object { $_.Lines -gt $RefactorThresholdLines }).Count

Write-Host ""
Write-Host "Summary"
Write-Host "Total files scanned: $($results.Count)"
Write-Host "Files above $TargetMaxLines lines: $warningCount"
Write-Host "Files above $RefactorThresholdLines lines: $refactorCount"

if ($FailOnRefactorThreshold -and $refactorCount -gt 0) {
	throw "$refactorCount file(s) exceed the $RefactorThresholdLines-line refactor threshold."
}

if ($FailOnWarning -and $warningCount -gt 0) {
	throw "$warningCount file(s) exceed the $TargetMaxLines-line warning threshold."
}
