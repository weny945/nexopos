@echo off
REM ============================================================
REM NexoPOS 计划任务设置脚本 (Windows)
REM 功能：设置每周一自动执行数据库备份
REM 使用：以管理员身份运行此脚本
REM ============================================================

SETLOCAL EnableDelayedExpansion

echo ============================================
echo   NexoPOS 计划任务设置工具
echo ============================================
echo.
echo 此脚本将创建一个 Windows 计划任务
echo 用于每周一凌晨 2:00 自动备份数据库
echo.
echo ============================================
echo.

REM 检查管理员权限
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo 错误: 此脚本需要管理员权限
    echo 请右键点击脚本，选择"以管理员身份运行"
    echo.
    pause
    EXIT /B 1
)

REM ============================================================
REM 配置区域
REM ============================================================

SET "SCRIPT_DIR=D:\develop\PHP_project\NexoPOS-master\scripts"
SET "BACKUP_SCRIPT=%SCRIPT_DIR%\backup-database.bat"
SET "TASK_NAME=NexoPOS_Weekly_Database_Backup"
SET "TASK_DESCRIPTION=NexoPOS 每周一数据库自动备份任务"

REM 检查备份脚本是否存在
IF NOT EXIST "%BACKUP_SCRIPT%" (
    echo 错误: 未找到备份脚本
    echo 路径: %BACKUP_SCRIPT%
    pause
    EXIT /B 1
)

REM ============================================================
REM 询问配置
REM ============================================================

echo 默认配置:
echo   任务名称: %TASK_NAME%
echo   执行时间: 每周一 凌晨 2:00
echo   脚本路径: %BACKUP_SCRIPT%
echo.

set /p "CUSTOM_TIME=是否自定义执行时间? (Y/N): "

IF /I "%CUSTOM_TIME%"=="Y" (
    echo.
    echo 时间格式: HH:mm (24小时制)
    echo 示例: 02:00 (凌晨2点), 14:30 (下午2点半)
    echo.
    set /p "HOUR=小时 (0-23): "
    set /p "MINUTE=分钟 (0-59): "
    SET "SCHEDULE_TIME=!HOUR!:!MINUTE!"
) ELSE (
    SET "SCHEDULE_TIME=02:00"
)

echo.
set /p "CUSTOM_DAY=是否自定义执行日期? (Y/N): "

IF /I "%CUSTOM_DAY%"=="Y" (
    echo.
    echo 选择星期:
    echo   [1] 星期一  [2] 星期二  [3] 星期三
    echo   [4] 星期四  [5] 星期五  [6] 星期六
    echo   [7] 星期日  [8] 每天
    echo.
    set /p "DAY_OPTION=请输入选项 (1-8): "

    IF "!DAY_OPTION!"=="1" SET "SCHEDULE_DAY=MON"
    IF "!DAY_OPTION!"=="2" SET "SCHEDULE_DAY=TUE"
    IF "!DAY_OPTION!"=="3" SET "SCHEDULE_DAY=WED"
    IF "!DAY_OPTION!"=="4" SET "SCHEDULE_DAY=THU"
    IF "!DAY_OPTION!"=="5" SET "SCHEDULE_DAY=FRI"
    IF "!DAY_OPTION!"=="6" SET "SCHEDULE_DAY=SAT"
    IF "!DAY_OPTION!"=="7" SET "SCHEDULE_DAY=SUN"
    IF "!DAY_OPTION!"=="8" SET "SCHEDULE_DAY=MON,TUE,WED,THU,FRI,SAT,SUN"

    IF NOT DEFINED SCHEDULE_DAY (
        echo 无效选项，使用默认值 (星期一)
        SET "SCHEDULE_DAY=MON"
    )
) ELSE (
    SET "SCHEDULE_DAY=MON"
)

echo.
echo ============================================
echo 计划任务配置确认
echo ============================================
echo.
echo 任务名称: %TASK_NAME%
echo 执行时间: 每周%SCHEDULE_DAY% %SCHEDULE_TIME%
echo 执行脚本: %BACKUP_SCRIPT%
echo.
set /p "CONFIRM=确认创建? (Y/N): "

IF /I NOT "%CONFIRM%"=="Y" (
    echo 操作已取消
    pause
    EXIT /B 0
)

REM ============================================================
REM 删除旧任务 (如果存在)
REM ============================================================
echo.
echo 正在检查旧任务...
schtasks /Query /TN "%TASK_NAME%" >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo 发现已存在的任务，正在删除...
    schtasks /Delete /TN "%TASK_NAME%" /F >nul 2>&1
    IF %ERRORLEVEL% EQU 0 (
        echo 旧任务已删除
    ) ELSE (
        echo 警告: 删除旧任务失败
    )
)

REM ============================================================
REM 创建新任务
REM ============================================================
echo 正在创建计划任务...

schtasks /Create /SC WEEKLY /D %SCHEDULE_DAY% /TN "%TASK_NAME%" /TR "\"%BACKUP_SCRIPT%\"" /ST %SCHEDULE_TIME% /RU SYSTEM /RL HIGHEST /F /V1

IF %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo  计划任务创建成功！
    echo ============================================
    echo.
    echo 任务名称: %TASK_NAME%
    echo 执行计划: 每周%SCHEDULE_DAY% %SCHEDULE_TIME%
    echo.
    echo 常用命令:
    echo   查看任务: schtasks /Query /TN "%TASK_NAME%"
    echo   立即运行: schtasks /Run /TN "%TASK_NAME%"
    echo   删除任务: schtasks /Delete /TN "%TASK_NAME%" /F
    echo   查看日志: %SCRIPT_DIR%\..\database\backups\backup.log
    echo.
) ELSE (
    echo.
    echo ============================================
    echo  计划任务创建失败！
    echo ============================================
    echo.
    echo 请检查:
    echo   1. 是否以管理员身份运行
    echo   2. 时间格式是否正确
    echo   3. 脚本路径是否正确
    echo.
)

pause
