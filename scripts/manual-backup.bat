@echo off
REM Switch to UTF-8 encoding
chcp 65001 >nul 2>&1

REM ============================================================
REM NexoPOS Manual Database Backup Script (Windows)
REM Usage: Double-click or run from command line
REM ============================================================

SETLOCAL EnableDelayedExpansion

REM Configuration
SET "PROJECT_DIR=D:\develop\PHP_project\NexoPOS-master"
SET "BACKUP_DIR=%PROJECT_DIR%\database\backups"
SET "DB_HOST=127.0.0.1"
SET "DB_PORT=3306"
SET "DB_NAME=nexopos"
SET "DB_USER=root"
SET "DB_PASS=Bwy15091620080"

echo ============================================
echo      NexoPOS Database Backup Tool
echo ============================================
echo.
echo Current Configuration:
echo   Database: %DB_NAME%
echo   Host:      %DB_HOST%:%DB_PORT%
echo   Backup Dir: %BACKUP_DIR%
echo.
echo ============================================
echo.
echo Please select backup type:
echo.
echo   [1] Full Backup (Recommended) - Data + Structure + Procedures
echo   [2] Schema Only - Table structure only, no data
echo   [3] Data Only - Data only, no structure
echo   [4] Custom Backup - Select specific tables
echo   [5] Quick Backup - Use default settings
echo.
set /p "CHOICE=Enter option (1-5): "

IF "%CHOICE%"=="5" GOTO :QUICK_BACKUP

REM Find MySQL path
SET "MYSQL_PATH="
IF EXIST "F:\mysql\MySQL Server 8.4\bin\mysqldump.exe" (
    SET "MYSQL_PATH=F:\mysql\MySQL Server 8.4\bin\"
) ELSE IF EXIST "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" (
    SET "MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 8.0\bin\"
) ELSE IF EXIST "C:\xampp\mysql\bin\mysqldump.exe" (
    SET "MYSQL_PATH=C:\xampp\mysql\bin\"
) ELSE IF EXIST "C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\mysqldump.exe" (
    SET "MYSQL_PATH=C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\"
) ELSE IF EXIST "D:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\mysqldump.exe" (
    SET "MYSQL_PATH=D:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\"
)

IF NOT DEFINED MYSQL_PATH (
    echo.
    echo Error: mysqldump.exe not found
    echo Please install MySQL client or set MYSQL_PATH variable
    pause
    EXIT /B 1
)

REM Create backup directory
IF NOT EXIST "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Generate timestamp
FOR /F "tokens=2 delims==" %%I IN ('wmic os get localdatetime /value') DO SET "DATETIME=%%I"
SET "TIMESTAMP=!DATETIME:~0,8!_!DATETIME:~8,6!"

IF "%CHOICE%"=="1" GOTO :FULL_BACKUP
IF "%CHOICE%"=="2" GOTO :SCHEMA_BACKUP
IF "%CHOICE%"=="3" GOTO :DATA_BACKUP
IF "%CHOICE%"=="4" GOTO :CUSTOM_BACKUP

echo Invalid option, exiting
pause
EXIT /B 1

:FULL_BACKUP
echo.
echo Performing full backup...
SET "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_full_%TIMESTAMP%.sql"
"!MYSQL_PATH!mysqldump.exe" --host=%DB_HOST% --port=%DB_PORT% --user=%DB_USER% --password=%DB_PASS% --single-transaction --routines --triggers --events %DB_NAME% > "%BACKUP_FILE%"
IF %ERRORLEVEL% EQU 0 (
    GOTO :SUCCESS
) ELSE (
    GOTO :ERROR
)

:SCHEMA_BACKUP
echo.
echo Performing schema-only backup...
SET "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_schema_%TIMESTAMP%.sql"
"!MYSQL_PATH!mysqldump.exe" --host=%DB_HOST% --port=%DB_PORT% --user=%DB_USER% --password=%DB_PASS% --no-data %DB_NAME% > "%BACKUP_FILE%"
IF %ERRORLEVEL% EQU 0 (
    GOTO :SUCCESS
) ELSE (
    GOTO :ERROR
)

:DATA_BACKUP
echo.
echo Performing data-only backup...
SET "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_data_%TIMESTAMP%.sql"
"!MYSQL_PATH!mysqldump.exe" --host=%DB_HOST% --port=%DB_PORT% --user=%DB_USER% --password=%DB_PASS% --no-create-info %DB_NAME% > "%BACKUP_FILE%"
IF %ERRORLEVEL% EQU 0 (
    GOTO :SUCCESS
) ELSE (
    GOTO :ERROR
)

:CUSTOM_BACKUP
echo.
echo Getting table list...
"!MYSQL_PATH!mysql.exe" --host=%DB_HOST% --port=%DB_PORT% --user=%DB_USER% --password=%DB_PASS% --skip-column-names %DB_NAME% -e "SHOW TABLES" > "%BACKUP_DIR%\tables_list.txt"

IF %ERRORLEVEL% NEQ 0 (
    echo Error: Cannot retrieve table list
    pause
    EXIT /B 1
)

echo.
echo Database tables:
SET /a COUNT=0
FOR /F "usebackq delims=" %%T IN ("%BACKUP_DIR%\tables_list.txt") DO (
    SET /a COUNT+=1
    echo   [!COUNT!] %%T
    SET "TABLE_!COUNT!=%%T"
)

echo.
set /p "TABLE_NUMS=Enter table numbers to backup (space separated, e.g. 1 3 5, or ALL): "

IF /I "%TABLE_NUMS%"=="ALL" (
    SET "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_custom_%TIMESTAMP%.sql"
    "!MYSQL_PATH!mysqldump.exe" --host=%DB_HOST% --port=%DB_PORT% --user=%DB_USER% --password=%DB_PASS% --single-transaction %DB_NAME% > "%BACKUP_FILE%"
) ELSE (
    SET "TABLES_TO_BACKUP="
    FOR %%N IN (%TABLE_NUMS%) DO (
        IF DEFINED TABLE_%%N (
            SET "TABLES_TO_BACKUP=!TABLES_TO_BACKUP! !TABLE_%%N!"
        )
    )
    SET "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_custom_%TIMESTAMP%.sql"
    "!MYSQL_PATH!mysqldump.exe" --host=%DB_HOST% --port=%DB_PORT% --user=%DB_USER% --password=%DB_PASS% --single-transaction %DB_NAME% !TABLES_TO_BACKUP! > "%BACKUP_FILE%"
)

del "%BACKUP_DIR%\tables_list.txt"
IF %ERRORLEVEL% EQU 0 (
    GOTO :SUCCESS
) ELSE (
    GOTO :ERROR
)

:QUICK_BACKUP
echo.
echo Performing quick backup...
CALL "%~dp0backup-database.bat"
EXIT /B %ERRORLEVEL%

:SUCCESS
echo.
echo ============================================
echo  Backup Successful!
echo ============================================
echo.
echo Backup file: %BACKUP_FILE%
FOR %%F IN ("%BACKUP_FILE%") DO (
    SET /a "SIZE_KB=%%~zF / 1024"
    echo File size: !SIZE_KB! KB
)
echo.

REM Ask to compress
set /p "COMPRESS=Compress backup file? (Y/N): "
IF /I "%COMPRESS%"=="Y" (
    IF EXIST "C:\Program Files\7-Zip\7z.exe" (
        echo Compressing...
        "C:\Program Files\7-Zip\7z.exe" a -tzip "%BACKUP_FILE%.zip" "%BACKUP_FILE%" -y > nul
        IF %ERRORLEVEL% EQU 0 (
            del "%BACKUP_FILE%"
            echo Compressed: %BACKUP_FILE%.zip
        )
    ) ELSE (
        echo 7-Zip not found, skipping compression
    )
)

echo.
echo Press any key to exit...
pause > nul
EXIT /B 0

:ERROR
echo.
echo ============================================
echo  Backup Failed!
echo ============================================
echo.
echo Please check:
echo   1. Database connection info is correct
echo   2. Database service is running
echo   3. User has sufficient privileges
echo.
pause
EXIT /B 1
