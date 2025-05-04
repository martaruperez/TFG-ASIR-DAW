#!/bin/bash
TIMESTAMP=$(date +%F-%H-%M)
mysqldump -u wp_user -p'wp_pass' wordpress > /tmp/backup.sql
aws s3 cp /tmp/backup.sql s3://tfg-marta-db-backups/backup.sql
