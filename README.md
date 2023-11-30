# ЛР 4.1-4.2 (ГРИГОРЬЕВ 4384)
> Теория языков программирования
## 1. Установка PostgreSQL
<a href="https://www.enterprisedb.com/downloads/postgres-postgresql-downloads" target="_blank"><img alt="Static Badge" src="https://img.shields.io/badge/PostgreSQL-16.1_(Windows_x86%E2%80%93x64)-blue?logo=postgresql"></a><br>
Инструкции и файлы установки для своей платформы стоит искать на <a href="https://www.postgresql.org/download/" target="_blank">**официальном сайте** <img src="https://upload.wikimedia.org/wikipedia/commons/2/29/Postgresql_elephant.svg" width="30px"></a>.<br>
Пошаговая инструкция по установке **PostgreSQL** в среде ОС **Windows** описана в отчёте по лабораторной работе.

## 2. Создание БД и подключение
1. Чтобы создать базу, запустите **SQL Shell** или обратитесь к **postgres** через командную строку и выполните
```sql
CREATE DATABASE ETO_BAZA;
```
2. Посмотрите список баз данных, используя `\l`, чтобы убедиться, что все прошло успешно.
1. Переключитесь на созданную базу, используя `\c ETO BAZA`. Все последующие запросы теперь будут выполняться в этой базе.
> [!TIP]
> Выполните `\! chcp 1251`, если есть проблемы с отображением кириллицы.

## 3. Импорт SQL запросов и проверка результатов
<a href="https://github.com/brabrobri/LABS-4.1-4.2-GRIGOREV-4384/blob/main/request.sql" target="_blank"><img alt="Static Badge" src="https://img.shields.io/badge/request-.sql-cornflowerblue"></a> <a href="https://github.com/brabrobri/LABS-4.1-4.2-GRIGOREV-4384/blob/main/output.txt" target="_blank"><img alt="Static Badge" src="https://img.shields.io/badge/output-.txt-limegreen"></a>
1. Выполните `\i 'request.sql'`, чтобы отправить в обработку пакет запросов SQL, а не вводить каждый запрос по отдельности.
1. Выполните `\o 'output.txt'`, чтобы сохранить результаты запросов во внешнем файле. Это необходимо при выполнении последнего задания из ЛР 4.2.
> [!NOTE]
> Чтобы вернуть вывод результатов в консоль, выполните `\o` без дополнительных параметров.

