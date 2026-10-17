# data-vault-hospital
Лабораторные работы по Data Vault 2.0 — приёмное отделение больницы
Вариант:10
СУБД: MySQL / MariaDB (phpMyAdmin)
Структура репозитория

- `01_3nf/` — модель данных в 3НФ
  - `3nf_schema.sql` — SQL-скрипт создания таблиц
  - `3nf_diagram.png` — ER-диаграмма
- `02_data_vault/` — модель Data Vault 2.0
  - `data_vault_schema.sql` — SQL-скрипт создания хабов, ссылок, сателлитов
  - `data_vault_diagram.png` — структурная схема
- `223-321_Березин_Лаб1.pdf` — отчёт по лабораторной работе
Как воспроизвести

1. Создайте базу `hospital_3nf` в phpMyAdmin.
2. Выполните `3nf_schema.sql`.
3. Создайте базу `dv_hospital`.
4. Выполните `data_vault_schema.sql`.
Автор
Березин Дмитрий Николаевич, 223-321
