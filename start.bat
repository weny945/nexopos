@echo off
chcp 65001 >nul
echo ========================================
echo 🚀 启动 NexoPOS 开发环境
echo ========================================
echo.

echo 📦 [1/2] 启动 Laravel 后端服务器...
start "NexoPOS Backend" cmd /k "php artisan serve"
timeout /t 2 >nul

echo ⚡ [2/2] 启动 Vite 前端开发服务器...
start "NexoPOS Frontend" cmd /k "npm run dev"

echo.
echo ========================================
echo ✅ 开发环境启动完成！
echo ========================================
echo.
echo 📱 访问地址: http://127.0.0.1:8000
echo.
echo 💡 提示:
echo    - 两个服务窗口已打开
echo    - 按 Ctrl+C 可停止服务
echo    - 关闭窗口即可停止所有服务
echo.
pause
