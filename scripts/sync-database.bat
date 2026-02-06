@echo off
chcp 65001 >nul 2>&1

REM 检查管理员权限，不够则自动提权重新启动
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    EXIT /B 0
)

REM ============================================================
REM NexoPOS 数据库同步脚本 (Windows)
REM 功能：从 backups 目录的 .sql 备份恢复到本地 MySQL
REM 备份目录: C:\inetpub\wwwroot\nexopos\database\backups
REM ============================================================

SETLOCAL EnableDelayedExpansion

REM ============================================================
REM 配置区域 - 与 .env 保持一致
REM ============================================================

REM 目标数据库 (当前环境)
SET "TARGET_HOST=127.0.0.1"
SET "TARGET_PORT=3306"
SET "TARGET_DB=nexopos_db"
SET "TARGET_USER=wenyuan"
SET "TARGET_PASS=Bwy15091620080"

REM 备份目录和日志
SET "BACKUP_DIR=C:\inetpub\wwwroot\nexopos\database\backups"
SET "PRE_SYNC_DIR=%BACKUP_DIR%\pre_sync"
SET "LOG_FILE=%BACKUP_DIR%\sync.log"

REM 同步前是否备份当前数据库
SET "BACKUP_BEFORE_SYNC=YES"

REM ============================================================
REM 初始化
REM ============================================================

IF NOT EXIST "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
IF NOT EXIST "%PRE_SYNC_DIR%" mkdir "%PRE_SYNC_DIR%"

REM 时间戳
FOR /F "tokens=2 delims==" %%I IN ('wmic os get localdatetime /value') DO SET "DATETIME=%%I"
SET "TIMESTAMP=!DATETIME:~0,8!_!DATETIME:~8,6!"

REM 查找 MySQL 客户端工具
SET "MYSQL_PATH="
IF EXIST "D:\MySQL\MySQL Server 8.4\bin\mysql.exe" (
    SET "MYSQL_PATH=D:\MySQL\MySQL Server 8.4\bin\"
) ELSE IF EXIST "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" (
    SET "MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 8.0\bin\"
) ELSE IF EXIST "C:\xampp\mysql\bin\mysql.exe" (
    SET "MYSQL_PATH=C:\xampp\mysql\bin\"
)

IF NOT DEFINED MYSQL_PATH (
    echo [ERROR] 未找到 MySQL 客户端工具，请检查安装路径
    pause
    EXIT /B 1
)

REM 日志开始
echo ================================ >> "%LOG_FILE%"
echo 同步开始: %date% %time% >> "%LOG_FILE%"
echo MySQL 路径: %MYSQL_PATH% >> "%LOG_FILE%"
echo 目标数据库: %TARGET_DB% (%TARGET_HOST%) >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

REM ============================================================
REM 扫描备份文件列表
REM ============================================================
echo.
echo ============================================
echo   NexoPOS 数据库备份同步工具
echo ============================================
echo.
echo 备份目录: %BACKUP_DIR%
echo.

SET "FILE_COUNT=0"
FOR /F "usebackq delims=" %%F IN (`dir /B /O-D "%BACKUP_DIR%\*.sql" 2^>nul`) DO (
    SET /a "FILE_COUNT=!FILE_COUNT!+1"
    SET "FILE_!FILE_COUNT!=%%F"
    echo   [!FILE_COUNT!] %%F
)

IF !FILE_COUNT! EQU 0 (
    echo.
    echo [ERROR] 备份目录中没有找到 .sql 备份文件
    echo 目录: %BACKUP_DIR%
    pause
    EXIT /B 1
)

echo.
echo 共 !FILE_COUNT! 个备份文件 (最新在上方)
echo.
echo 选择:
echo   [0] 使用最新备份 (默认)
echo   [1-!FILE_COUNT!] 手动选择
echo.
set /p "FILE_CHOICE=请输入编号 (默认 0): "

IF "%FILE_CHOICE%"=="" SET "FILE_CHOICE=0"

IF "!FILE_CHOICE!"=="0" (
    SET "SELECTED_FILE=!FILE_1!"
) ELSE (
    CALL SET "SELECTED_FILE=%%FILE_!FILE_CHOICE!%%"
)

IF NOT DEFINED SELECTED_FILE (
    echo [ERROR] 无效选择
    pause
    EXIT /B 1
)

SET "IMPORT_SRC=%BACKUP_DIR%\!SELECTED_FILE!"

REM ============================================================
REM 确认同步操作
REM ============================================================
echo.
echo ============================================
echo 同步确认
echo ============================================
echo.
echo  备份文件: !SELECTED_FILE!
echo  目标数据库: %TARGET_DB%
echo.
echo [*] 此操作将覆盖 %TARGET_DB% 数据库的所有数据
echo.
set /p "CONFIRM=输入 YES 确认: "

IF /I NOT "%CONFIRM%"=="YES" (
    echo 同步已取消 >> "%LOG_FILE%"
    echo 同步已取消
    EXIT /B 0
)

echo 选定文件: !SELECTED_FILE! >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

REM ============================================================
REM 步骤 1/3: 备份当前目标数据库
REM ============================================================
IF /I "%BACKUP_BEFORE_SYNC%"=="YES" (
    echo.
    echo [步骤 1/3] 备份当前数据库...
    SET "PRE_BACKUP=%PRE_SYNC_DIR%\%TARGET_DB%_before_sync_%TIMESTAMP%.sql"

    "!MYSQL_PATH!mysqldump.exe" --host=%TARGET_HOST% --port=%TARGET_PORT% --user=%TARGET_USER% --password=%TARGET_PASS% --single-transaction --routines --triggers --events %TARGET_DB% > "!PRE_BACKUP!" 2>>"%LOG_FILE%"

    IF !ERRORLEVEL! EQU 0 (
        echo   OK - 备份已保存: !PRE_BACKUP!
        echo [步骤1] 当前数据库备份成功: !PRE_BACKUP! >> "%LOG_FILE%"
    ) ELSE (
        echo   [ERROR] 备份当前数据库失败，同步中止
        echo [步骤1] 备份失败 >> "%LOG_FILE%"
        pause
        EXIT /B 1
    )
    echo. >> "%LOG_FILE%"
)

REM ============================================================
REM 步骤 2/3: 清空目标数据库的表
REM ============================================================
echo.
echo [步骤 2/3] 清空目标数据库...

"!MYSQL_PATH!mysql.exe" --host=%TARGET_HOST% --port=%TARGET_PORT% --user=%TARGET_USER% --password=%TARGET_PASS% --skip-column-names %TARGET_DB% -e "SHOW TABLES" > "%BACKUP_DIR%\_drop_list.txt" 2>>"%LOG_FILE%"

IF !ERRORLEVEL! EQU 0 (
    FOR /F "usebackq delims=" %%T IN ("%BACKUP_DIR%\_drop_list.txt") DO (
        IF NOT "%%T"=="" (
            "!MYSQL_PATH!mysql.exe" --host=%TARGET_HOST% --port=%TARGET_PORT% --user=%TARGET_USER% --password=%TARGET_PASS% %TARGET_DB% -e "SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS %%T; SET FOREIGN_KEY_CHECKS=1;" 2>>"%LOG_FILE%"
            echo   DROP: %%T >> "%LOG_FILE%"
        )
    )
    del "%BACKUP_DIR%\_drop_list.txt" 2>nul
    echo   OK - 所有表已删除
    echo [步骤2] 表清空完成 >> "%LOG_FILE%"
) ELSE (
    echo   [WARNING] 获取表列表失败，继续尝试导入...
    echo [步骤2] 获取表列表失败 >> "%LOG_FILE%"
)
echo. >> "%LOG_FILE%"

REM ============================================================
REM 步骤 3/3: 导入备份文件
REM ============================================================
echo.
echo [步骤 3/3] 导入备份文件...
echo   文件: !SELECTED_FILE!
echo 导入文件: !SELECTED_FILE! >> "%LOG_FILE%"

"!MYSQL_PATH!mysql.exe" --host=%TARGET_HOST% --port=%TARGET_PORT% --user=%TARGET_USER% --password=%TARGET_PASS% %TARGET_DB% < "!IMPORT_SRC!" 2>>"%LOG_FILE%"
SET "IMPORT_RC=!ERRORLEVEL!"

IF !IMPORT_RC! EQU 0 (
    echo   OK - 导入成功
    echo [步骤3] 导入成功 >> "%LOG_FILE%"
) ELSE (
    echo   [ERROR] 导入失败，请检查日志: %LOG_FILE%
    echo [步骤3] 导入失败 >> "%LOG_FILE%"
    pause
    EXIT /B 1
)
echo. >> "%LOG_FILE%"

REM ============================================================
REM 验证: 统计导入后表数量
REM ============================================================
echo.
echo 正在验证...

"!MYSQL_PATH!mysql.exe" --host=%TARGET_HOST% --port=%TARGET_PORT% --user=%TARGET_USER% --password=%TARGET_PASS% --skip-column-names %TARGET_DB% -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='%TARGET_DB%'" > "%BACKUP_DIR%\_verify.txt" 2>>"%LOG_FILE%"
SET /p "TABLE_COUNT=" < "%BACKUP_DIR%\_verify.txt"
del "%BACKUP_DIR%\_verify.txt" 2>nul

echo   目标数据库表数量: !TABLE_COUNT!
echo [验证] 导入后表数量: !TABLE_COUNT! >> "%LOG_FILE%"

REM ============================================================
REM 完成
REM ============================================================
echo. >> "%LOG_FILE%"
echo 同步完成: %date% %time% >> "%LOG_FILE%"
echo ================================ >> "%LOG_FILE%"
echo.
echo ============================================
echo  同步完成！
echo ============================================
echo.
echo  恢复的备份: !SELECTED_FILE!
echo  目标数据库: %TARGET_DB% (!TABLE_COUNT! 个表)
IF /I "%BACKUP_BEFORE_SYNC%"=="YES" (
    echo  同步前备份: !PRE_BACKUP!
)
echo  日志文件: %LOG_FILE%
echo.

pause
ENDLOCAL
