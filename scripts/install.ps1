# Copy Cranky Review 2.0 skills into a consumer repo.
# Usage: .\scripts\install.ps1 [-Target C:\path\to\repo]
# Default target: current directory.

param(
    [string]$Target = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

$PackRoot = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path (Join-Path $PackRoot "skills\cranky"))) {
    throw "install.ps1: cannot find skills\cranky under $PackRoot"
}
if (-not (Test-Path $Target -PathType Container)) {
    throw "install.ps1: target is not a directory: $Target"
}

function Copy-Skill {
    param([string]$Name, [string]$DestRoot)
    New-Item -ItemType Directory -Force -Path $DestRoot | Out-Null
    $dest = Join-Path $DestRoot $Name
    if (Test-Path $dest) {
        Remove-Item -Recurse -Force $dest
    }
    Copy-Item -Recurse (Join-Path $PackRoot "skills\$Name") $dest
}

foreach ($rel in @(".agents\skills", ".claude\skills", ".grok\skills")) {
    $destRoot = Join-Path $Target $rel
    Copy-Skill -Name "cranky" -DestRoot $destRoot
    Copy-Skill -Name "merge" -DestRoot $destRoot
    Copy-Skill -Name "cleanse" -DestRoot $destRoot
}

$cmdDir = Join-Path $Target ".claude\commands"
$agentDir = Join-Path $Target ".claude\agents"
New-Item -ItemType Directory -Force -Path $cmdDir, $agentDir | Out-Null
Get-ChildItem (Join-Path $PackRoot "adapters\claude\commands") -Filter *.md | Copy-Item -Destination $cmdDir
Copy-Item (Join-Path $PackRoot "adapters\claude\agents\cranky-reviewer.md") $agentDir

$claudeMd = Join-Path $Target "CLAUDE.md"
if (-not (Test-Path $claudeMd)) {
    Copy-Item (Join-Path $PackRoot "CLAUDE.md") $claudeMd
    Write-Host "installed CLAUDE.md pointer (target had none)"
}

$agentsDir = Join-Path $Target "AGENTS"
if (-not (Test-Path $agentsDir)) {
    New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
    Copy-Item -Recurse (Join-Path $PackRoot "templates\AGENTS\*") $agentsDir
    Write-Host "installed AGENTS/ templates (target had none; seed INVARIANTS before relying on cranky)"
}
else {
    Write-Host "left existing AGENTS/ untouched"
}

$cursorDir = Join-Path $Target ".cursor\rules"
New-Item -ItemType Directory -Force -Path $cursorDir | Out-Null
$mdc = Join-Path $cursorDir "cranky.mdc"
if (-not (Test-Path $mdc)) {
    Copy-Item (Join-Path $PackRoot "adapters\cursor\cranky.mdc") $mdc
}

Write-Host "Cranky Review 2.0 installed into $Target"
Write-Host "  skills -> .agents/skills .claude/skills .grok/skills"
Write-Host "Next: write AGENTS/overlays/overlay-<product>.md and seed AGENTS/DNA/INVARIANTS.md"
Write-Host "Inspired by https://github.com/ulfaslak/saas_tmplt - see NOTICE.md"
