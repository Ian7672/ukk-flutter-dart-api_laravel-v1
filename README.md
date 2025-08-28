# UKK Flutter + Laravel v1

Aplikasi mobile (Flutter) dengan backend API (Laravel) untuk kebutuhan autentikasi dasar, ganti password, dan CRUD sederhana. Proyek ini ditujukan sebagai bahan UKK dan pembelajaran praktik full‑stack mobile + REST API.

---

## 🔗 Repository
`https://github.com/Ian7672/ukk-flutter-dart-api_laravel-v1`

---

## ✨ Fitur Utama
- Autentikasi: Register, Login, Logout
- Ganti password
- CRUD data contoh (dapat disesuaikan)
- Penyimpanan token/sesi di mobile dengan `shared_preferences`
- Struktur code rapi dan mudah dikembangkan

---

## 🧱 Arsitektur Singkat
- Frontend: Flutter (Dart) — UI, request HTTP ke API Laravel
- Backend: Laravel (PHP) — REST API, autentikasi, validasi, database

---

## 🛠️ Teknologi
- Flutter SDK (Dart)
  - `http`
  - `shared_preferences`
- Laravel 10+
  - Sanctum (opsional untuk token)
  - MySQL/MariaDB

---

## 📂 Struktur Folder Penting

```text
flutter/
  lib/
    api_service.dart       # HTTP client & helper API
    main.dart              # Entry point Flutter
    models/                # Model data (e.g. User)
    screens/               # Halaman UI (login/register/home/change password)
  pubspec.yaml             # Dependency dan konfigurasi Flutter

laravel/
  app/                     # Kode aplikasi (Models, Http/Controllers, Middleware)
  config/                  # Konfigurasi Laravel (app, auth, cors, database, dll)
  database/
    migrations/            # Skema tabel (users, tokens, password_resets, failed_jobs)
  resources/
    views/                 # Blade templates (mis. welcome.blade.php)
  routes/
    api.php                # Rute API (endpoint untuk Flutter)
    web.php                # Rute web (Blade/SSR)
  .env                     # Konfigurasi environment (buat dari .env.example)
  artisan                  # CLI Laravel
```

Referensi langsung:
- `lib/`
- `pubspec.yaml`
- `resources/views/`
- `routes/`
- `database/migrations/`
- `app/`
- `config/`
- `README.md` (file ini)

---

## ✅ Prasyarat

- Flutter SDK (disarankan sesuai `environment.sdk` pada `pubspec.yaml`)
- PHP 8.1+
- Composer
- MySQL/MariaDB
- Node.js (opsional untuk tooling front-end Laravel kalau diperlukan)

---

## ⚙️ Setup Backend (Laravel)
   ```bash
   git clone https://github.com/Ian7672/ukk-flutter-dart-api_laravel-v1
   ```

   ```bash
   composer install
   cp .env.example .env
   php artisan key:generate
   php artisan migrate --seed
   php artisan serve
   ```

   ```bash
   flutter pub get
   flutter run
   ```


1) Masuk direktori:
```bash
cd laravel
```

2) Install dependency:
```bash
composer install
```

3) Duplikasi berkas environment:
```bash
cp .env.example .env
php artisan key:generate
```

4) Konfigurasi `.env`:
- `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`
- Atur CORS bila perlu di `config/cors.php`
- Jika menggunakan Sanctum/API token, pastikan konfigurasi sesuai di `config/sanctum.php`

5) Migrasi database (opsional seed bila tersedia):
```bash
php artisan migrate --seed
```

6) Jalankan server:
```bash
php artisan serve
```
Akses di `http://127.0.0.1:8000`

Tips:
- Endpoint API didefinisikan di `routes/api.php`
- Endpoint web/Blade didefinisikan di `routes/web.php`

---

## 📱 Setup Frontend (Flutter)

1) Masuk direktori:
```bash
cd flutter
```

2) Ambil dependency:
```bash
flutter pub get
```

3) Konfigurasi URL API di `lib/api_service.dart` (base URL Laravel, mis. `http://127.0.0.1:8000`):
- Pastikan endpoint sesuai dengan `routes/api.php`
- Untuk Android emulator, seringkali gunakan `http://10.0.2.2:8000`

4) Jalankan aplikasi:
```bash
flutter run
```

Pastikan device/emulator aktif.

---

## 🔑 Konfigurasi Penting

- `config/auth.php`: Guard & provider autentikasi
- `config/cors.php`: Izinkan origin aplikasi Flutter saat development
- `routes/api.php`: Sumber kebenaran endpoint yang diakses Flutter
- `database/migrations/`: Skema tabel user, tokens, password reset, dsb.

Di sisi Flutter:
- `lib/api_service.dart`: Base URL, header `Content-Type`, autentikasi/token
- `lib/screens/`: Implementasi UI login, register, ganti password
- `shared_preferences`: Simpan token/sesi setelah login

---

## 🧪 Testing (Opsional)
Laravel:
```bash
php artisan test
# atau
vendor/bin/phpunit
```

Flutter widget test:
```bash
flutter test
```

---

## 🚀 Build Release

Flutter:
```bash
# Android
flutter build apk --release

# iOS (butuh Xcode & macOS)
flutter build ios --release
```

Laravel (production):
- Sesuaikan `.env` (APP_ENV=production, cache config/route/view)
```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

---

## 🔍 Troubleshooting

- CORS error: pastikan `config/cors.php` mengizinkan origin/dev port Flutter; clear config cache:
  ```bash
  php artisan config:clear && php artisan cache:clear
  ```
- Tidak bisa akses API dari Android emulator: gunakan `http://10.0.2.2:8000`
- Migrasi gagal: cek kredensial DB di `.env` dan pastikan DB sudah dibuat
- Token/auth tidak tersimpan: cek penggunaan `shared_preferences` di Flutter dan format header Authorization di `api_service.dart`

---

## 🧾 Lisensi
Proyek untuk pembelajaran/UKK. Gunakan dengan bijak dan tanpa komersialisasi tanpa izin.

---

## 👤 Kredit
- Pengembang: Ian (ian7672)
