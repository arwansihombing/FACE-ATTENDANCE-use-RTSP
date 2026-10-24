#!/bin/bash
set -e
echo "Face Attendance v4 - One Click Start"
if ! command -v docker &> /dev/null; then echo "Docker tidak ada"; exit 1; fi
if docker compose version &> /dev/null; then COMPOSE="docker compose"; else COMPOSE="docker-compose"; fi
[ -f laravel-app/.env ] || cp laravel-app/.env.example laravel-app/.env
$COMPOSE up -d --build
sleep 10
$COMPOSE exec app php artisan key:generate --force
$COMPOSE exec app php artisan migrate --seed --force
echo "Web: http://localhost:8000"
