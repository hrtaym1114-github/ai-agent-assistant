@echo off
REM ============================================================
REM  build-zip.bat - Package ai-agent-assistant for distribution
REM ============================================================
REM  Usage: build-zip.bat [output_name]
REM  Default output: ai-agent-assistant.zip
REM
REM  Excluded:
REM    .git/  logs/  .claude/settings.local.json  *.zip  build-zip.bat
REM ============================================================

setlocal enabledelayedexpansion

set "PROJECT_DIR=%~dp0"
set "ZIP_NAME=%~1"
if "%ZIP_NAME%"=="" set "ZIP_NAME=ai-agent-assistant.zip"

set "OUTPUT_PATH=%PROJECT_DIR%%ZIP_NAME%"

echo.
echo === AI Agent Assistant - ZIP Builder ===
echo.

REM Remove existing zip if present
if exist "%OUTPUT_PATH%" (
    echo Removing existing: %ZIP_NAME%
    del /f "%OUTPUT_PATH%"
)

echo Creating: %ZIP_NAME%
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$projectDir = '%PROJECT_DIR%'.TrimEnd('\');" ^
  "$outputPath = '%OUTPUT_PATH%';" ^
  "$tempDir = Join-Path $env:TEMP ('aaa-zip-' + [guid]::NewGuid().ToString('N').Substring(0,8));" ^
  "New-Item -ItemType Directory -Path $tempDir -Force | Out-Null;" ^
  "$destRoot = Join-Path $tempDir 'ai-agent-assistant';" ^
  "New-Item -ItemType Directory -Path $destRoot -Force | Out-Null;" ^
  "$excludeDirs = @('.git', 'logs');" ^
  "$excludeFiles = @('settings.local.json', '*.zip', 'build-zip.bat');" ^
  "Get-ChildItem -Path $projectDir -Force | Where-Object {" ^
  "  $name = $_.Name;" ^
  "  $isExcludedDir = ($_.PSIsContainer -and ($excludeDirs -contains $name));" ^
  "  $isExcludedFile = (-not $_.PSIsContainer -and ($excludeFiles | Where-Object { $name -like $_ }));" ^
  "  -not $isExcludedDir -and -not $isExcludedFile" ^
  "} | ForEach-Object {" ^
  "  $dest = Join-Path $destRoot $_.Name;" ^
  "  if ($_.PSIsContainer) {" ^
  "    Copy-Item -Path $_.FullName -Destination $dest -Recurse -Force" ^
  "  } else {" ^
  "    Copy-Item -Path $_.FullName -Destination $dest -Force" ^
  "  }" ^
  "};" ^
  "$localSettings = Join-Path $destRoot '.claude\settings.local.json';" ^
  "if (Test-Path $localSettings) { Remove-Item $localSettings -Force };" ^
  "Compress-Archive -Path $destRoot -DestinationPath $outputPath -Force;" ^
  "Remove-Item -Path $tempDir -Recurse -Force;" ^
  "Write-Host '';" ^
  "Write-Host ('Done: ' + $outputPath);" ^
  "$size = (Get-Item $outputPath).Length;" ^
  "Write-Host ('Size: ' + [math]::Round($size / 1024, 1) + ' KB')"

echo.
echo === Complete ===
echo.

endlocal
