#!/usr/bin/env pwsh
# TIFINYA WebUI - Rebuild Script
# This script rebuilds the Open WebUI container with TIFINYA customizations

Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  TIFINYA WebUI - Rebuild Script" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
Write-Host "[1/5] Checking Docker status..." -ForegroundColor Yellow
try {
    docker ps | Out-Null
    Write-Host "      ✓ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "      ✗ Docker is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Stop and remove existing containers
Write-Host ""
Write-Host "[2/5] Stopping existing containers..." -ForegroundColor Yellow
docker compose down
Write-Host "      ✓ Containers stopped" -ForegroundColor Green

# Build the image with no cache
Write-Host ""
Write-Host "[3/5] Building Open WebUI image (no cache)..." -ForegroundColor Yellow
Write-Host "      This may take several minutes..." -ForegroundColor Gray
docker compose build --no-cache openwebui
if ($LASTEXITCODE -ne 0) {
    Write-Host "      ✗ Build failed!" -ForegroundColor Red
    exit 1
}
Write-Host "      ✓ Build completed successfully" -ForegroundColor Green

# Start the containers
Write-Host ""
Write-Host "[4/5] Starting containers..." -ForegroundColor Yellow
docker compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "      ✗ Failed to start containers!" -ForegroundColor Red
    exit 1
}
Write-Host "      ✓ Containers started" -ForegroundColor Green

# Show container status
Write-Host ""
Write-Host "[5/5] Container status:" -ForegroundColor Yellow
docker compose ps

Write-Host ""
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  Rebuild complete!" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Open WebUI should be available at:" -ForegroundColor White
Write-Host "  http://localhost:8080" -ForegroundColor Cyan
Write-Host ""
Write-Host "To view logs, run:" -ForegroundColor White
Write-Host "  docker compose logs -f openwebui" -ForegroundColor Gray
Write-Host ""
