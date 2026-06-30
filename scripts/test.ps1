param(
	[ValidateSet("quick", "docs", "visual", "mobile-like", "full")]
	[string]$Tier = "quick",
	[string]$Godot = ""
)

$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

function Resolve-GodotCommand {
	if ($Godot -ne "") {
		return $Godot
	}

	$defaultWindowsPath = "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe"
	if (Test-Path -LiteralPath $defaultWindowsPath) {
		return $defaultWindowsPath
	}

	return "godot"
}

function Invoke-Step {
	param(
		[string]$Name,
		[scriptblock]$Command
	)

	Write-Host "==> $Name"
	$global:LASTEXITCODE = 0
	$previousErrorActionPreference = $ErrorActionPreference
	$ErrorActionPreference = "Continue"
	try {
		$output = & $Command 2>&1
		$exitCode = $global:LASTEXITCODE
	}
	finally {
		$ErrorActionPreference = $previousErrorActionPreference
	}
	if ($exitCode -ne 0) {
		$output | ForEach-Object { Write-Host $_ }
		throw "$Name failed with exit code $exitCode"
	}
	if ($env:OCEANGAME_TEST_VERBOSE -eq "1") {
		$output | ForEach-Object { Write-Host $_ }
	}
	Write-Host "PASS $Name"
}

$godotCommand = Resolve-GodotCommand

switch ($Tier) {
	"quick" {
		Invoke-Step "Godot headless launch" {
			& $godotCommand --headless --path . --quit-after 1
		}
		Invoke-Step "Godot logic tests" {
			& $godotCommand --headless --path . --script res://tests/logic_tests.gd
		}
		Invoke-Step "Area 01 source truth validation" {
			& $godotCommand --headless --path . --script res://tests/area01_source_truth_validation.gd
		}
		Invoke-Step "Area 01 runtime placement validation" {
			node tools/validate-area01-runtime-placements.mjs
		}
		Invoke-Step "Whitespace check" {
			git diff --check
		}
		Write-Host "PASS quick tier"
	}
	"docs" {
		Invoke-Step "MCP context self-test" {
			node .mcp/oceangame-context-server.mjs --self-test
		}
		Invoke-Step "Area 01 runtime source map validation" {
			node tools/validate-area01-runtime-source-map.mjs
		}
		Invoke-Step "Area 01 runtime placement validation" {
			node tools/validate-area01-runtime-placements.mjs
		}
		Invoke-Step "Whitespace check" {
			git diff --check
		}
		Write-Host "PASS docs tier"
	}
	"visual" {
		Invoke-Step "Desktop Playwright visual smoke against existing export" {
			npm.cmd run test:visual:existing
		}
		Invoke-Step "Whitespace check" {
			git diff --check
		}
		Write-Host "PASS visual tier"
	}
	"mobile-like" {
		Invoke-Step "Mobile-like Playwright visual smoke against existing export" {
			npm.cmd run test:visual:mobile-like:existing
		}
		Invoke-Step "Whitespace check" {
			git diff --check
		}
		Write-Host "PASS mobile-like tier"
	}
	"full" {
		Invoke-Step "Godot headless launch" {
			& $godotCommand --headless --path . --quit-after 1
		}
		Invoke-Step "Godot logic tests" {
			& $godotCommand --headless --path . --script res://tests/logic_tests.gd
		}
		Invoke-Step "Area 01 source truth validation" {
			& $godotCommand --headless --path . --script res://tests/area01_source_truth_validation.gd
		}
		Invoke-Step "MCP context self-test" {
			node .mcp/oceangame-context-server.mjs --self-test
		}
		Invoke-Step "Area 01 runtime source map validation" {
			node tools/validate-area01-runtime-source-map.mjs
		}
		Invoke-Step "Area 01 runtime placement validation" {
			node tools/validate-area01-runtime-placements.mjs
		}
		Invoke-Step "Desktop Playwright export and visual smoke" {
			npm.cmd run test:visual
		}
		Invoke-Step "Mobile-like Playwright export and visual smoke" {
			npm.cmd run test:visual:mobile-like
		}
		Invoke-Step "Whitespace check" {
			git diff --check
		}
		Write-Host "PASS full tier"
	}
}
