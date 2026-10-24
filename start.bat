@echo off
title Face Attendance v4 - One Click Start
color 0A
echo ============================================
echo  Face Attendance v4 - One Click Installer
echo  Medan, Indonesia - Asia/Jakarta
echo ============================================
echo.

where docker >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo [ERROR] Docker tidak ditemukan!
  echo Install Docker Desktop dulu: https://www.docker.com/products/docker-desktop/
  pause
  exit /b
)

where docker-compose >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo [INFO] pakai docker compose v2
  set COMPOSE_CMD=docker compose
) else (
  set COMPOSE_CMD=docker-compose
)

echo [1/5] Cek .env...
if not exist laravel-app\.env (
  copy laravel-app\.env.example laravel-app\.env
  echo .env dibuat
)

echo [2/5] Build images...
%COMPOSE_CMD% up -d --build

echo [3/5] Tunggu PostgreSQL ready...
timeout /t 10 /nobreak >nul

echo [4/5] Setup Laravel...
%COMPOSE_CMD% exec app php artisan key:generate --force
%COMPOSE_CMD% exec app php artisan migrate --seed --force
%COMPOSE_CMD% exec app php artisan storage:link

echo [5/5] Selesai!
echo ============================================
echo  Web: http://localhost:8000
echo  Admin: admin@sekolah.test / password
echo  Operator: operator_a / op123456
echo ============================================
start http://localhost:8000
pause
