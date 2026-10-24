# Face Attendance - Improved Version v2.0
Production ready - Laravel 11 + PostgreSQL + pgvector + Redis + Python Worker (InsightFace)

## Apa yang di-improve dari file asli?
1. **Security**: Argon2id, Rate Limiter 5x login, Guard terpisah operator & staff, HMAC internal API, AuditLog middleware
2. **Architecture**: Service Layer + Enum Role + Policies + FormRequest + Events/Listener
3. **DB**: pgvector migrasi ke HNSW (lebih cepat dari IVFFlat), unique constraint attendance idempoten, indexes
4. **Performance**: Redis queue, Laravel Reverb WebSocket, RingBuffer 25 frame, Batch inference 100ms
5. **Code Quality**: PHP 8.3 typed, Enums, DTO, PHPStan ready, Pest tests scaffold
6. **Python Worker**: FastAPI + Manager multiprocess, GPU fallback CPU, heartbeat, snapshot S3 local, versioned embedding
7. **DevOps**: docker-compose lengkap (pgsql+pgvector, redis, app, reverb, worker), Makefile, .env.example

## Quick Start
```bash
unzip face-attendance-improved.zip
cd face-attendance-improved
cp laravel-app/.env.example laravel-app/.env
docker-compose up -d --build
docker exec app php artisan key:generate
docker exec app php artisan migrate --seed
docker exec app php artisan storage:link
```
Buka http://localhost:8000
- Staff: admin@sekolah.test / password
- Operator: operator Gerbang A / op123456

## Struktur
- laravel-app/ : Laravel 11
- python-worker/ : FastAPI worker
- docker-compose.yml
