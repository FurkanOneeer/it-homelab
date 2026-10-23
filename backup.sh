#!/bin/bash

# Yedeklerin kaydedilecegi klasor
BACKUP_DIR="/home/$USER/it-homelab/backups"

# Anlik tarih ve saat damgasi (Ornek: 20261023_164500)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Klasor yoksa olustur
mkdir -p "$BACKUP_DIR"

# Docker konteynerinin icine girip pg_dump komutu ile veritabanini disari aktar
docker exec -t local_postgres pg_dump -U dbuser company_db > "$BACKUP_DIR/company_db_$TIMESTAMP.sql"

# Guvenlik ve depolama optimizasyonu: 7 gunden eski .sql dosyalarini otomatik sil (Rotation)
find "$BACKUP_DIR" -type f -name "*.sql" -mtime +7 -delete

echo "Yedekleme tamamlandi: $BACKUP_DIR/company_db_$TIMESTAMP.sql"
