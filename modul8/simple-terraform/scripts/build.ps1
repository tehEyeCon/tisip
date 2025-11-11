# Build script for Windows (PowerShell)
$ErrorActionPreference = "Stop"

Write-Host "📦 Building Terraform Artifact..." -ForegroundColor Green
Write-Host ""

# Generate version
if (Get-Command git -ErrorAction SilentlyContinue) {
    $VERSION = git rev-parse --short HEAD
} else {
    $VERSION = Get-Date -Format "yyyyMMdd-HHmmss"
}

Write-Host "Version: $VERSION" -ForegroundColor Cyan
Write-Host ""

# Validate Terraform
Write-Host "1️⃣ Validating Terraform..." -ForegroundColor Yellow
Set-Location terraform
terraform fmt -check -recursive
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Run 'terraform fmt -recursive' to fix formatting" -ForegroundColor Red
    exit 1
}
terraform init -backend=false
terraform validate
Set-Location ..

Write-Host "✅ Validation complete!" -ForegroundColor Green
Write-Host ""

# --- Create artifact (tar.gz) ---
# $PSScriptRoot peker på mappen der skriptet ligger: ...\scripts
$ScriptDir = $PSScriptRoot
$RepoRoot  = (Resolve-Path (Join-Path $ScriptDir '..')).Path   # én nivå opp = repo-roten

$ArtifactName = "terraform-$VERSION.tar.gz"
$ArtifactPath = Join-Path $RepoRoot $ArtifactName

# Sjekk at mapper finnes i repo-roten
$required = @('terraform','environments','backend-configs') |
  ForEach-Object { Join-Path $RepoRoot $_ }
$missing = $required | Where-Object { -not (Test-Path $_) }
if ($missing) { throw "Missing folders: $($missing -join ', ')" }

# Pakk fra repo-roten (-C) og ta med riktige mapper
tar -czf $ArtifactPath -C $RepoRoot terraform environments backend-configs

# Verifiser innhold
$entries = tar -tf $ArtifactPath
if (-not $entries -or $entries.Count -eq 0) { throw "Artifact is empty." }

Write-Host "✅ Artifact created: $ArtifactPath" -ForegroundColor Green

