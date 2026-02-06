@echo off
REM ============================================================
REM NexoPOS 数据库自动备份脚本 (Windows)
REM 功能：备份 MySQL 数据库，保留最近 8 周的备份
REM 计划：每周一凌晨 2:00 执行
REM ============================================================

SETLOCAL EnableDelayedExpansion

REM 配置区域 - 根据实际情况修改
SET "PROJECT_DIR=D:\develop\PHP_project\NexoPOS-master"
SET "BACKUP_DIR=%PROJECT_DIR%\database\backups"
SET "DB_HOST=127.0.0.1"
SET "DB_PORT=3306"
SET "DB_NAME=nexopos"
SET "DB_USER=root"
SET "DB_PASS=Bwy15091620080"
SET "DB_PREFIX=ns_"
SET "RETENTION_WEEKS=8"

REM 日志文件
SET "LOG_FILE=%BACKUP_DIR%\backup.log"

REM 时间戳格式: YYYYMMDD_HHMMSS
FOR /F "tokens=2 delims==" %%I IN ('wmic os get localdatetime /value') DO SET "DATETIME=%%I"
SET "TIMESTAMP=!DATETIME:~0,8!_!DATETIME:~8,6!"

REM 创建备份目录（如果不存在）
IF NOT EXIST "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
)

REM 开始日志记录
echo ================================ >> "%LOG_FILE%"
echo 备份开始时间: %date% %time% >> "%LOG_FILE%"
echo 数据库: %DB_NAME% >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

REM 备份文件名
SET "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_%TIMESTAMP%.sql"

REM ============================================================
REM 方法 1: 使用 mysqldump (推荐，需要 MySQL 安装路径)
REM ============================================================
echo 正在备份数据库... >> "%LOG_FILE%"

REM 尝试常见 MySQL 安装路径
SET "MYSQL_PATH="
IF EXIST "F:\mysql\MySQL Server 8.4\bin\mysqldump.exe" (
    SET "MYSQL_PATH=F:\mysql\MySQL Server 8.4\bin\"
) ELSE IF EXIST "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" (
    SET "MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 8.0\bin\"
) ELSE IF EXIST "C:\Program Files\MySQL\MySQL Server 5.7\bin\mysqldump.exe" (
    SET "MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 5.7\bin\"
) ELSE IF EXIST "C:\xampp\mysql\bin\mysqldump.exe" (
    SET "MYSQL_PATH=C:\xampp\mysql\bin\"
) ELSE IF EXIST "C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\mysqldump.exe" (
    SET "MYSQL_PATH=C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\"
)

IF DEFINED MYSQL_PATH (
    echo 使用 MySQL 路径: !MYSQL_PATH! >> "%LOG_FILE%"
    "!MYSQL_PATH!mysqldump.exe" --host=%DB_HOST% --port=%DB_PORT% --user=%DB_USER% --password=%DB_PASS% --single-transaction --routines --triggers --events %DB_NAME% > "%BACKUP_FILE%" 2>>"%LOG_FILE%"

    IF !ERRORLEVEL! EQU 0 (
        echo 备份成功: %BACKUP_FILE% >> "%LOG_FILE%"

        REM 压缩备份文件 (如果有 7-Zip)
        IF EXIST "C:\Program Files\7-Zip\7z.exe" (
            echo 正在压缩备份文件... >> "%LOG_FILE%"
            "C:\Program Files\7-Zip\7z.exe" a -tzip "%BACKUP_FILE%.zip" "%BACKUP_FILE%" -y >> "%LOG_FILE%" 2>&1
            IF !ERRORLEVEL! EQU 0 (
                del "%BACKUP_FILE%"
                SET "BACKUP_FILE=%BACKUP_FILE%.zip"
                echo 压缩成功: !BACKUP_FILE! >> "%LOG_FILE%"
            )
        )

        REM 获取文件大小
        FOR %%F IN ("%BACKUP_FILE%") DO SET "SIZE=%%~zF"
        SET /a "SIZE_MB=!SIZE! / 1048576"
        echo 备份文件大小: !SIZE_MB! MB >> "%LOG_FILE%"

    ) ELSE (
        echo 错误: mysqldump 执行失败，错误代码: !ERRORLEVEL! >> "%LOG_FILE%"
        EXIT /B 1
    )
) ELSE (
    echo 错误: 未找到 mysqldump.exe，请手动设置 MYSQL_PATH 变量 >> "%LOG_FILE%"
    echo 常见位置: >> "%LOG_FILE%"
    echo   - C:\Program Files\MySQL\MySQL Server 8.0\bin\ >> "%LOG_FILE%"
    echo   - C:\xampp\mysql\bin\ >> "%LOG_FILE%"
    echo   - C:\laragon\bin\mysql\*version*\bin\ >> "%LOG_FILE%"
    EXIT /B 1
)

REM ============================================================
REM 清理旧备份 (保留最近 N 周)
REM ============================================================
echo. >> "%LOG_FILE%"
echo 正在清理 %RETENTION_WEEKS% 周前的旧备份... >> "%LOG_FILE%"

REM 使用 PowerShell 清理旧文件
powershell -Command "Get-ChildItem '%BACKUP_DIR%\%DB_NAME%_*.sql*' ^| Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-%RETENTION_WEEKS%*7) } ^| Remove-Item -Force" >> "%LOG_FILE%" 2>&1

IF %ERRORLEVEL% EQU 0 (
    echo 旧备份清理完成 >> "%LOG_FILE%"
) ELSE (
    echo 警告: 清理旧备份时出错 >> "%LOG_FILE%"
)

REM ============================================================
REM 备份统计信息
REM ============================================================
echo. >> "%LOG_FILE%"
echo 当前备份文件列表: >> "%LOG_FILE%"
FOR /F "delims=" %%F IN ('dir /B /O-D "%BACKUP_DIR%\%DB_NAME%_*.sql*" 2^>nul') DO echo   %%F >> "%LOG_FILE%"

REM 完成
echo. >> "%LOG_FILE%"
echo 备份完成时间: %date% %time% >> "%LOG_FILE%"
echo ================================ >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

REM 显示结果
echo 数据库备份完成！
echo 备份文件: %BACKUP_FILE%
echo 查看日志: %LOG_FILE%

ENDLOCAL
