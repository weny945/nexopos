# NexoPOS Windows Server 生产环境部署指南

## 目录

- [系统要求](#系统要求)
- [部署前准备](#部署前准备)
- [软件安装](#软件安装)
- [环境配置](#环境配置)
- [IIS Web 服务器配置](#iis-web-服务器配置)
- [数据库配置](#数据库配置)
- [Redis 配置](#redis-配置)
- [部署应用](#部署应用)
- [队列和计划任务](#队列和计划任务)
- [性能优化](#性能优化)
- [安全加固](#安全加固)
- [备份策略](#备份策略)
- [故障排查](#故障排查)
  - [500 错误（响应体为空）](#1-页面显示-500-错误响应体为空)
  - [bat 脚本闪消失](#7-bat-脚本双击后闪一下就消失)
  - [https 访问不到](#8-https-访问不到http-可以)
- [维护和监控](#维护和监控)

---

## 系统要求

### 最低要求

- **操作系统**: Windows Server 2019 / 2022 或 Windows 10/11 Pro
- **处理器**: Intel Core i3 或同等性能处理器
- **内存**: 最低 4GB RAM，推荐 8GB+
- **磁盘空间**: 最低 20GB 可用空间，推荐 50GB+
- **网络**: 稳定的互联网连接

### 软件要求

- **Web Server**: IIS 10.0 或更高版本
- **PHP**: 8.2 或更高版本（非线程安全版本）
- **MySQL**: 8.0+ 或 MariaDB 10.3+
- **Redis**: 6.0+ (用于缓存和队列)
- **Node.js**: 18.0+ LTS 版本
- **Composer**: 2.0+
- **Git**: 最新版本

### PHP 扩展要求

确保安装以下 PHP 扩展：
- BCMath
- Ctype
- cURL
- DOM
- Fileinfo
- JSON
- Mbstring
- OpenSSL
- PDO
- PDO MySQL
- Tokenizer
- XML
- Zip
- GD 或 ImageMagick

---

## 部署前准备

### 1. 系统更新

确保 Windows Server 已安装最新的更新：

```powershell
# 以管理员身份运行 PowerShell
Install-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install -AutoReboot
```

### 2. 启用 IIS

打开 **服务器管理器** → **管理** → **添加角色和功能**：

- 选择 **Web 服务器 (IIS)**
- 添加以下角色服务：
  - Web 服务器
  - 应用程序开发
    - CGI
    - ISAPI 扩展
    - ISAPI 筛选器
  - 常见 HTTP 功能
    - 默认文档
    - 目录浏览
    - HTTP 错误
    - HTTP 重定向
    - 静态内容
    - URL 授权
  - 性能功能
    - 静态内容压缩
    - 动态内容压缩

或者使用 PowerShell：

```powershell
Import-Module ServerManager
Install-WindowsFeature Web-Server -IncludeAllSubFeature
Install-WindowsFeature Web-Mgmt-Tools
```

### 3. 启用 .NET Framework 4.x

```powershell
Install-WindowsFeature NET-Framework-45-Core
Install-WindowsFeature NET-Framework-45-ASPNET
```

### 4. 创建网站目录

```powershell
# 创建项目目录
New-Item -ItemType Directory -Path "C:\inetpub\wwwroot\nexopos" -Force

# 设置权限
$IISUser = "IUSR"
$IISGroup = "IIS_IUSRS"
$Acl = Get-Acl "C:\inetpub\wwwroot\nexopos"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IISGroup,"FullControl","ContainerInherit,ObjectInherit","None","Allow")
$Acl.SetAccessRule($AccessRule)
Set-Acl "C:\inetpub\wwwroot\nexopos" $Acl
```

---

## 软件安装

### 1. 安装 PHP

#### 方法一：使用 PHP 官方包（推荐）

1. **下载 PHP**
   - 访问 https://windows.php.net/download/
   - 下载 PHP 8.2.x (x64 Non Thread Safe)
   - 下载地址：https://windows.php.net/downloads/releases/php-8.2/archives/

2. **解压 PHP**
   ```powershell
   # 创建 PHP 目录
   New-Item -ItemType Directory -Path "C:\PHP" -Force

   # 解压到 C:\PHP (使用 7-Zip 或 WinRAR)
   ```

3. **配置 php.ini**
   ```powershell
   # 复制配置文件
   Copy-Item "C:\PHP\php.ini-production" "C:\PHP\php.ini"

   # 编辑 php.ini
   notepad "C:\PHP\php.ini"
   ```

   修改以下配置：
   ```ini
   ; 基本配置
   extension_dir = "ext"

   ; 必需扩展
   extension=bcmath
   extension=curl
   extension=mbstring
   extension=mysqlnd
   extension=openssl
   extension=pdo_mysql
   extension=zip
   extension=fileinfo
   extension=gd
   extension=dom

   ; 时区设置
   date.timezone = Asia/Shanghai

   ; 上传配置
   upload_max_filesize = 100M
   post_max_size = 100M
   memory_limit = 256M
   max_execution_time = 300

   ; Session 配置
   session.save_path = "C:\PHP\sessions"
   session.gc_maxlifetime = 1440

   ; FastCGI 配置
   fastcgi.impersonate = 1
   cgi.fix_pathinfo = 1

   ; 错误日志（生产环境）
   log_errors = On
   error_log = "C:\PHP\logs\php_errors.log"
   display_errors = Off
   display_startup_errors = Off
   ```

4. **创建必需目录**
   ```powershell
   New-Item -ItemType Directory -Path "C:\PHP\sessions" -Force
   New-Item -ItemType Directory -Path "C:\PHP\uploads" -Force
   New-Item -ItemType Directory -Path "C:\PHP\logs" -Force
   ```

5. **添加 PHP 到系统 PATH**
   - 右键点击 **此电脑** → **属性** → **高级系统设置**
   - 点击 **环境变量**
   - 在 **系统变量** 中找到 **Path**，点击 **编辑**
   - 添加 `C:\PHP` 和 `C:\PHP\ext`

6. **验证 PHP 安装**
   ```powershell
   php -v
   php -m
   ```

#### 方法二：使用 IIS Express for PHP

下载并安装 **PHP Manager for IIS**：
- 下载：https://github.com/phpmanager/phpmanager/releases
- 安装后通过 IIS 管理器配置 PHP

### 2. 安装 VCRedist（运行时库）

PHP 需要 Visual C++ Redistributable：

- 下载并安装：https://aka.ms/vs/17/release/vc_redist.x64.exe
- 或 PHP 8.2 需要的 Visual Studio 2022 运行时

### 3. 安装 MySQL

#### 下载和安装 MySQL

1. **下载 MySQL**
   - 访问 https://dev.mysql.com/downloads/mysql/
   - 下载 MySQL Installer 8.0.x

2. **安装 MySQL**
   - 运行安装程序
   - 选择 **Custom** 安装类型
   - 选择以下组件：
     - MySQL Server
     - MySQL Workbench
     - MySQL Shell
   - 设置 root 密码（务必记住）
   - 配置端口：3306
   - 启用 TCP/IP 网络
   - 选择 **Standalone MySQL Server**

3. **创建 NexoPOS 数据库**
   ```powershell
   # 使用 MySQL Workbench 或命令行
   mysql -u root -p
   ```

   ```sql
   CREATE DATABASE nexopos_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   CREATE USER 'wenyuan'@'localhost' IDENTIFIED BY 'Bwy15091620080';
   # 已经配置了 wenyuan Bwy15091620080
   GRANT ALL PRIVILEGES ON nexopos_db.* TO 'wenyuan'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   ```

#### MySQL 配置优化

编辑 `my.ini`（通常位于 `C:\ProgramData\MySQL\MySQL Server 8.0\`）：

```ini
[mysqld]
# InnoDB 配置
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 2

# 查询缓存
query_cache_size = 64M
query_cache_limit = 2M

# 连接配置
max_connections = 200
max_allowed_packet = 64M

# 字符集
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

# 日志
log-error = "C:/ProgramData/MySQL/Logs/error.log"
```

重启 MySQL 服务：
```powershell
Restart-Service MySQL
```

### 4. 安装 Redis

#### 方法一：使用 Memurai（推荐用于 Windows）

1. **下载 Memurai**
   - 访问 https://www.memurai.com/get-memurai
   - 下载 Memurai for Windows（免费用于开发）

2. **安装和配置**
   - 解压到 `C:\Memurai`
   - 运行 `memurai.exe`
   - Redis 将在 `localhost:6379` 上运行

3. **配置为 Windows 服务并开机自启**
   ```powershell
   # 使用 nssm（推荐）
   # 下载 nssm: https://nssm.cc/download

   # 安装为服务
   nssm install Memurai "C:\Memurai\memurai.exe"

   # 设置服务自动启动
   nssm set Memurai Start SERVICE_AUTO_START

   # 启动服务
   nssm start Memurai

   # 验证服务状态
   nssm status Memurai
   ```

#### 方法二：使用 Docker

```powershell
# 安装 Docker Desktop for Windows
# 运行 Redis 容器
docker run -d -p 6379:6379 --name redis redis:alpine
```

### 5. 安装 Git

1. **下载 Git**
   - 访问 https://git-scm.com/download/win
   - 下载并安装 Git for Windows

2. **验证安装**
   ```powershell
   git --version
   ```

### 6. 安装 Composer

1. **下载 Composer**
   - 访问 https://getcomposer.org/download/
   - 下载 Composer-Setup.exe

2. **安装 Composer**
   - 运行安装程序
   - 选择 PHP 路径：`C:\PHP\php.exe`
   - 安装完成后验证：
   ```powershell
   composer --version
   ```

3. **配置 Composer 镜像（中国用户可选）**
   ```powershell
   composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
   ```

### 7. 安装 Node.js 和 npm

1. **下载 Node.js**
   - 访问 https://nodejs.org/
   - 下载 LTS 版本（推荐 18.x 或 20.x）

2. **安装 Node.js**
   - 运行安装程序
   - 验证安装：
   ```powershell
   node -v
   npm -v
   ```

3. **配置 npm 镜像（中国用户可选）**
   ```powershell
   npm config set registry https://registry.npmmirror.com
   ```

### 8. 安装 NSSM（可选，用于管理服务）

1. **下载 NSSM**
   - 访问 https://nssm.cc/download
   - 下载最新版本
   - 解压到 `C:\nssm`

2. **添加到 PATH**
   - 将 `C:\nssm` 添加到系统 PATH

---

## 环境配置

### 1. 克隆或上传项目

#### 使用 Git 克隆

```powershell
cd C:\inetpub\wwwroot
git clone https://github.com/blair2004/NexoPOS.git nexopos
cd nexopos
git checkout v5.0.x
```

#### 手动上传

1. 压缩项目文件为 zip 格式
2. 上传到服务器
3. 解压到 `C:\inetpub\wwwroot\nexopos`

### 2. 安装依赖

```powershell
cd C:\inetpub\wwwroot\nexopos

# 安装 PHP 依赖（生产环境）
composer install --no-dev --optimize-autoloader

# 安装前端依赖
npm install

# 构建前端资源
npm run build
```

### 3. 配置环境变量

```powershell
# 复制环境配置文件
Copy-Item .env.example .env

# 生成应用密钥
php artisan key:generate
```

编辑 `.env` 文件：

```ini
APP_NAME="NexoPOS"
APP_ENV=production
APP_DEBUG=false
APP_URL=http://localhost

# 数据库配置
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=nexopos_db
DB_USERNAME=nexopos_user
DB_PASSWORD=your_strong_password


# Redis 配置
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis

# Redis 服务器配置
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

# 广播配置（可选）
BROADCAST_DRIVER=reverb
REVERB_APP_ID=your_app_id
REVERB_APP_KEY=your_app_key
REVERB_APP_SECRET=your_app_secret

# 队列配置
QUEUE_CONNECTION=redis

# 时区
APP_TIMEZONE=Asia/Shanghai
```

---

## IIS Web 服务器配置

### 1. 配置 FastCGI

#### 方法一：使用 PHP Manager（推荐）

1. **安装 PHP Manager for IIS**
   - 下载：https://github.com/phpmanager/phpmanager/releases
   - 运行安装程序

2. **注册 PHP**
   - 打开 **IIS 管理器**
   - 双击 **PHP Manager**
   - 点击 **Register new PHP version**
   - 输入 PHP 名称：`PHP 8.2`
   - 选择 PHP 可执行文件：`C:\PHP\php-cgi.exe`
   - 点击 **OK**

3. **配置 FastCGI 设置**
   - 在 PHP Manager 中选择 PHP 8.2
   - 点击 **PHP.ini** → **Edit**
   - 确保配置正确

#### 方法二：手动配置 FastCGI

1. **安装 CGI 模块**
   ```powershell
   Import-Module ServerManager
   Install-WindowsFeature Web-CGI
   ```

2. **配置 FastCGI**
   - 打开 **IIS 管理器**
   - 选择服务器节点
   - 双击 **FastCGI 设置**
   - 点击 **添加**
   - 完整路径：`C:\PHP\php-cgi.exe`
   - 监控器：`C:\PHP\php-cgi.exe`

3. **配置 FastCGI 环境变量**
   - 选择刚添加的 FastCGI 应用程序
   - 点击 **编辑**
   - 添加以下环境变量：
     - `PHP_FCGI_MAX_REQUESTS`: `10000`
     - `PHPRC`: `C:\PHP\php.ini`

### 1-1. 修复 PHP Handler 的 HTTP 方法限制（必须执行）

> PHP Manager 和手动 FastCGI 注册默认只为 `*.php` 映射 `GET,HEAD,POST` 三种方法。Laravel 的 REST API 依赖 `PUT`（保存/更新）和 `DELETE`（删除）请求，这两种方法会被 IIS 丢给默认的 `StaticFile` 处理器，导致**所有保存和删除操作都返回 404**。
>
> 这是 IIS + Laravel 部署上最容易遗漏的坑。

**症状**: 页面能打开，登录能成功，但任何保存（PUT）或删除（DELETE）操作都报 404。

**验证当前状态**:
```powershell
Import-Module WebAdministration
Get-WebHandler | Where-Object { $_.Path -eq "*.php" }
# 如果 Verb 列显示 "GET,HEAD,POST"，需要执行下面的修复
```

**修复**（将 Verb 改为 `*`，接受所有 HTTP 方法）:
```powershell
Import-Module WebAdministration
# php-8.2.30 替换为上面 Get-WebHandler 输出的实际 Name
Set-WebHandler -Name "php-8.2.30" -Verb "*"
```

**验证修复**:
```powershell
Get-WebHandler | Where-Object { $_.Path -eq "*.php" }
# Verb 列应显示 "*"
```

---

### 2. 创建 IIS 网站

1. **添加网站**
   - 打开 **IIS 管理器**
   - 右键 **网站** → **添加网站**
   - 网站名称：`NexoPOS`
   - 物理路径：`C:\inetpub\wwwroot\nexopos\public`
   - 绑定：`http`，端口 `80`，IP 地址 `*`
   - 点击 **确定**

2. **配置应用程序池**
   - 在 IIS 管理器中，点击 **应用程序池**
   - 右键 → **添加应用程序池**
   - 名称：`NexoPOS Pool`
   - .NET CLR 版本：**无托管代码**
   - 托管管道模式：**经典**
   - 点击 **确定**

3. **将网站分配到应用程序池**
   - 选择 **NexoPOS** 网站
   - 在右侧 **操作** 面板中点击 **基本设置**
   - 点击 **选择** 按钮，选择 **NexoPOS Pool**
   - 点击 **确定**

### 3. 配置 URL 重写

1. **安装 URL 重写模块**
   ```powershell
   # 下载：https://www.iis.net/downloads/microsoft/url-rewrite-module
   # 或使用 Web Platform Installer
   ```

2. **配置重写规则**

   项目已在 `public/web.config` 中提供了正确的 IIS 重写规则，只要网站物理路径指向 `public/` 目录，IIS 会**自动读取**该文件，规则无需手动添加。

   **注意**：不要在 IIS 管理器中使用"导入规则"从 `.htaccess` 导入。`.htaccess` 是 Apache 格式，IIS 的转换器经常无法正确处理其中的语法，会导致导入失败或规则错误。

   `public/web.config` 中的重写规则如下：

   ```xml
   <configuration>
     <system.webServer>
       <rewrite>
         <rules>
           <!-- 规则1：去除末尾斜杠，301 重定向 /foo/ → /foo -->
           <rule name="Imported Rule 1" stopProcessing="true">
             <match url="^(.*)/$" ignoreCase="false" />
             <conditions>
               <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" negate="true" />
             </conditions>
             <action type="Redirect" redirectType="Permanent" url="/{R:1}" />
           </rule>
           <!-- 规则2：非静态文件请求均转发到 Laravel 入口控制器 -->
           <rule name="Imported Rule 2" stopProcessing="true">
             <match url="^(.*)$" ignoreCase="false" />
             <conditions>
               <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" negate="true" />
               <add input="{REQUEST_FILENAME}" matchType="IsFile" ignoreCase="false" negate="true" />
             </conditions>
             <action type="Rewrite" url="index.php/{R:1}" appendQueryString="true" />
           </rule>
         </rules>
       </rewrite>
     </system.webServer>
   </configuration>
   ```

### 4. 配置请求过滤和 MIME 类型

1. **设置请求限制**
   - 选择 **NexoPOS** 网站
   - 双击 **请求筛选**
   - 点击 **编辑功能设置**
   - 最大允许内容长度（字节）：`104857600` (100MB)

2. **添加 MIME 类型**
   - 双击 **MIME 类型**
   - 点击 **添加**
   - 文件扩展名：`.json`
   - MIME 类型：`application/json`

### 5. 配置压缩

- 选择 **NexoPOS** 网站
- 双击 **压缩**
- 勾选 **启用动态内容压缩**
- 勾选 **启用静态内容压缩**

---

## 数据库配置

### MySQL 优化配置

已在前面的 **安装 MySQL** 部分说明。

### 测试数据库连接

```powershell
cd C:\inetpub\wwwroot\nexopos
php artisan tinker
```

```php
>>> DB::connection()->getPdo();
=> PDO { ... }
>>> exit
```

---

## Redis 配置

### 配置 Redis 服务

#### 使用 Memurai

1. **创建配置文件**
   ```powershell
   New-Item -ItemType File -Path "C:\Memurai\memurai.conf" -Force
   ```

   编辑配置文件：
   ```ini
   # 内存配置
   maxmemory 256mb
   maxmemory-policy allkeys-lru

   # 持久化
   save 900 1
   save 300 10
   save 60 10000

   # 日志
   logfile "C:/Memurai/logs/redis-server.log"
   loglevel notice
   ```

2. **启动 Redis**
   ```powershell
   & "C:\Memurai\memurai.exe" memurai.conf
   ```

3. **测试连接**
   ```powershell
   & "C:\Memurai\memurai-cli.exe" ping
   # 应该返回 PONG
   ```

### 使用 Redis 命令行工具

```powershell
# 测试 Redis
& "C:\Memurai\memurai-cli.exe" -h 127.0.0.1 -p 6379
```

---

## 部署应用

### 1. 运行数据库迁移

```powershell
cd C:\inetpub\wwwroot\nexopos

# 创建符号链接
php artisan storage:link

# 创建语言文件链接
php artisan ns:translate --symlink --force

# 创建模块链接
php artisan modules:symlink

# 运行数据库迁移
php artisan migrate --force

# 清除缓存
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
```

### 2. 优化生产环境

```powershell
# 优化配置
php artisan config:cache

# 优化路由
php artisan route:cache

# 优化视图
php artisan view:compile
```

### 3. 设置文件权限

> **注意**：IIS 的 PHP FastCGI 进程默认以 `IUSR` 身份运行（可通过在 `public/` 下放一个 `<?php echo get_current_user(); ?>` 确认）。`IIS_IUSRS` 组的继承权限在某些目录结构下不会正确生效，因此必须**直接给 `IUSR` 授权**，不能仅依赖 `IIS_IUSRS` 组权限。

```powershell
# 给 IUSR 直接授 storage 和 bootstrap/cache 的 FullControl
# 必须对这两个目录都执行，否则 Laravel 无法写入缓存、日志、编译模板
$paths = @(
    "C:\inetpub\wwwroot\nexopos\storage",
    "C:\inetpub\wwwroot\nexopos\bootstrap\cache"
)
foreach ($path in $paths) {
    $acl = Get-Acl $path
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        "IUSR", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow"
    )
    $acl.AddAccessRule($rule)
    Set-Acl $path $acl
}
```

---

## 队列和计划任务

### 1. 配置队列 Worker

#### 使用 NSSM 创建服务

```powershell
# 定义服务名称
$serviceName = "NexoPOSQueueWorker"
$phpPath = "C:\PHP\php.exe"
$artisanPath = "C:\inetpub\wwwroot\nexopos\artisan"
$appDir = "C:\inetpub\wwwroot\nexopos"

# 安装服务
& "C:\nssm\nssm.exe" install $serviceName $phpPath "$artisanPath queue:work" ` $appDir -Display "NexoPOS Queue Worker"

# 配置服务
& "C:\nssm\nssm.exe" set $serviceName AppDirectory $appDir
& "C:\nssm\nssm.exe" set $serviceName AppEnvironmentExtra "APP_ENV=production"
& "C:\nssm\nssm.exe" set $serviceName AppStopMethodSkip 0
& "C:\nssm\nssm.exe" set $serviceName AppStdout "$appDir\storage\logs\worker.log"
& "C:\nssm\nssm.exe" set $serviceName AppStderr "$appDir\storage\logs\worker.log"
& "C:\nssm\nssm.exe" set $serviceName AppRotateFiles 1
& "C:\nssm\nssm.exe" set $serviceName AppRotateBytes 10485760

# 启动服务
& "C:\nssm\nssm.exe" start $serviceName

# 设置服务自动启动
& "C:\nssm\nssm.exe" set $serviceName Start SERVICE_AUTO_START
```

#### 验证队列服务

```powershell
# 检查服务状态
& "C:\nssm\nssm.exe" status NexoPOSQueueWorker

# 重启服务
& "C:\nssm\nssm.exe" restart NexoPOSQueueWorker

# 停止服务
& "C:\nssm\nssm.exe" stop NexoPOSQueueWorker

# 卸载服务
& "C:\nssm\nssm.exe" remove NexoPOSQueueWorker confirm
```

### 2. 配置计划任务

#### 设置所有服务开机自启

```powershell
# MySQL 服务自动启动
Set-Service MySQL84 -StartupType Automatic

# Redis/Memurai 服务自动启动
Set-Service Memurai -StartupType Automatic

# 验证服务启动类型
Get-Service MySQL84 | Select-Object Name, StartType
Get-Service Memurai | Select-Object Name, StartType
```

**重要提示**: 队列服务和 Reverb 服务在创建时已通过 NSSM 配置为自动启动（使用 `Start SERVICE_AUTO_START`）。

#### 使用任务计划程序

1. **打开任务计划程序**
   - Win + R → 输入 `taskschd.msc` → 回车

2. **创建基本任务**
   - 点击右侧 **创建基本任务**
   - 名称：`NexoPOS Scheduler`
   - 触发器：**新建** → **每天**
     - 开始：`12:00:00 AM`
     - 重复间隔：`1` 天
   - 操作：**启动程序**
     - 程序或脚本：`C:\PHP\php.exe`
     - 参数：`C:\inetpub\wwwroot\nexopos\artisan schedule:run`
     - 起始于：`C:\inetpub\wwwroot\nexopos`

3. **高级设置**
   - 在 **条件** 选项卡中：
     - 电源：勾选 **"仅在计算机使用交流电源时才启动此任务"**
     - 网络：勾选 **"仅在以下网络连接可用时启动"** → 选择任何连接

#### 使用 PowerShell 创建任务

```powershell
$trigger = New-ScheduledTaskTrigger -Daily -At "12:00am"
$action = New-ScheduledTaskAction -Execute "C:\PHP\php.exe" `
    -Argument "C:\inetpub\wwwroot\nexopos\artisan schedule:run" `
    -WorkingDirectory "C:\inetpub\wwwroot\nexopos"
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName "NexoPOS Scheduler" -Trigger $trigger -Action $action -Settings $settings -User "SYSTEM"
```

### 3. 配置 WebSocket（可选）

如果要使用实时功能（Reverb）：

```powershell
# 创建 Reverb 服务
$serviceName = "NexoPOSReverb"
$phpPath = "C:\PHP\php.exe"
$artisanPath = "C:\inetpub\wwwroot\nexopos\artisan"
$appDir = "C:\inetpub\wwwroot\nexopos"

# 安装服务
& "C:\nssm\nssm.exe" install $serviceName $phpPath "$artisanPath reverb:start" `
    $appDir -Display "NexoPOS Reverb Server"

# 配置服务
& "C:\nssm\nssm.exe" set $serviceName AppDirectory $appDir
& "C:\nssm\nssm.exe" set $serviceName AppEnvironmentExtra "APP_ENV=production"
& "C:\nssm\nssm.exe" set $serviceName AppStdout "$appDir\storage\logs\reverb.log"
& "C:\nssm\nssm.exe" set $serviceName AppStderr "$appDir\storage\logs\reverb.log"

# 启动服务
& "C:\nssm\nssm.exe" start $serviceName

# 设置服务自动启动
& "C:\nssm\nssm.exe" set $serviceName Start SERVICE_AUTO_START
```

---

## 性能优化

### 1. PHP OPcache 配置

编辑 `C:\PHP\php.ini`：

```ini
; OPcache 配置
opcache.enable=1
opcache.memory_consumption=256
opcache.interned_strings_buffer=16
opcache.max_accelerated_files=10000
opcache.revalidate_freq=60
opcache.fast_shutdown=1
opcache.enable_cli=0
opcache.validate_timestamps=0
opcache.save_comments=1
opcache.enable_file_override=1
```

重启 IIS：
```powershell
iisreset
```

### 2. IIS 压缩配置

已在 **IIS Web 服务器配置** 部分说明。

### 3. MySQL 优化

已在 **数据库配置** 部分说明。

### 4. 应用缓存优化

```powershell
cd C:\inetpub\wwwroot\nexopos

# 缓存配置、路由和视图
php artisan config:cache
php artisan route:cache
php artisan view:compile
```

### 5. 启用 HTTP/2

在 IIS 中启用 HTTP/2：

1. 打开 **IIS 管理器**
2. 选择服务器节点
3. 双击 **HTTP 响应头**
4. 点击 **添加**
5. 名称：`X-Content-Type-Options`
6. 值：`nosniff`
7. 确保站点绑定使用 HTTPS（HTTP/2 需要 HTTPS）

---

## 安全加固

### 1. 配置 SSL/TLS

#### 使用自签名证书（仅用于测试）

```powershell
# 创建自签名证书
$cert = New-SelfSignedCertificate -DnsName "localhost" -CertStoreLocation "Cert:\LocalMachine\My"
$thumbprint = $cert.Thumbprint

# 导出证书
$certPath = "C:\inetpub\wwwroot\certificate.pfx"
$pwd = ConvertTo-SecureString "password" -AsPlainText -Force
Export-PfxCertificate -Cert $cert -FilePath $certPath -Password $pwd

# 在 IIS 中导入证书
```

#### 使用 Let's Encrypt（推荐）

1. **安装 win-acme**
   ```powershell
   # 下载：https://www.win-acme.com/
   # 或使用 chocolatey
   choco install win-acme
   ```

2. **申请证书**
   ```powershell
   # 获取证书
   win-acme.v2.exe --issue --dns manual --domain your-domain.com
   ```

3. **在 IIS 中配置 SSL**
   - 打开 **IIS 管理器**
   - 选择服务器节点 → **服务器证书**
   - **导入** → 选择证书文件
   - 选择网站 → **绑定** → **添加**
   - 类型：`https`
   - 端口：`443`
   - SSL 证书：选择导入的证书

### 2. 配置防火墙

使用 Windows 防火墙：

```powershell
# 允许 HTTP
New-NetFirewallRule -DisplayName "NexoPOS HTTP" `
    -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow

# 允许 HTTPS
New-NetFirewallRule -DisplayName "NexoPOS HTTPS" `
    -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow

# 允许 MySQL（如果需要远程访问）
New-NetFirewallRule -DisplayName "MySQL" `
    -Direction Inbound -LocalPort 3306 -Protocol TCP -Action Allow
```

### 3. 隐藏 PHP 版本信息

编辑 `C:\PHP\php.ini`：

```ini
expose_php = Off
```

### 4. 文件上传限制

已在 **安装 PHP** 部分说明。

### 5. 配置请求筛选

在 IIS 中：

1. 选择 **NexoPOS** 网站
2. 双击 **请求筛选**
3. **编辑功能设置**
4. **拒绝的文件扩展名**：添加 `.env, .git, .htaccess`
5. **允许的文件扩展名**：添加 `.php, .jpg, .png, .gif, .pdf, .css, .js`

---

## 备份策略

### 1. 使用项目提供的备份脚本

详见 `scripts\README.md`，Windows 版本的脚本位于：

- `backup-database.bat` - 自动备份脚本
- `manual-backup.bat` - 手动备份脚本
- `sync-database.bat` - 数据库同步脚本
- `schedule-backup.bat` - 计划任务设置脚本

### 2. 配置自动备份

#### 使用任务计划程序

1. **打开任务计划程序**
   - Win + R → 输入 `taskschd.msc`

2. **创建备份任务**
   - 名称：`NexoPOS Database Backup`
   - 触发器：每天凌晨 2 点
   - 操作：
     ```
     程序：C:\inetpub\wwwroot\nexopos\scripts\backup-database.bat
     ```

3. **配置备份保留策略**
   - 编辑 `backup-database.bat`
   - 修改 `RETENTION_WEEKS` 变量

### 3. 完整备份脚本

创建完整备份脚本 `C:\inetpub\wwwroot\nexopos\scripts\backup-all.bat`：

```batch
@echo off
echo ====================================
echo NexoPOS Complete Backup Script
echo ====================================

SET PROJECT_DIR=C:\inetpub\wwwroot\nexopos
SET BACKUP_DIR=%PROJECT_DIR%\storage\backups
SET DATE=%date:~0,4%%date:~5,2%%date:~8,2%
SET TIME=%time:~0,2%%time:~3,2%%time:~6,2%

echo [%DATE% %TIME%] Starting backup...

mkdir "%BACKUP_DIR%" 2>nul

echo [%DATE% %TIME%] Backing up database...
call "%PROJECT_DIR%\scripts\backup-database.bat"

echo [%DATE% %TIME%] Backing up uploaded files...
set UPLOADS_BACKUP="%BACKUP_DIR%\uploads_%DATE%_%TIME%.zip"
powershell -Command "Compress-Archive -Path '%PROJECT_DIR%\storage\app\public\uploads' -DestinationPath '%UPLOADS_BACKUP%'"

echo [%DATE% %TIME%] Backup completed!
echo.
echo Database backup: %BACKUP_DIR%\nexopos_*.sql
echo Uploads backup: %UPLOADS_BACKUP%
pause
```

---

## 故障排查

### 1. 页面显示 500 错误（响应体为空）

**问题**: 浏览器显示"无法使用此页面"，或 HTTP 500 但没有任何错误信息。

**根因**（最常见）: `storage/` 或 `bootstrap/cache/` 目录对 `IUSR` 没有写权限。Laravel 编译模板、写日志、写缓存都会失败，导致 500 且响应体为空。

**排查步骤**:

1. **临时开启调试信息**——编辑 `.env`，将 `APP_DEBUG=false` 改为 `APP_DEBUG=true`，然后刷新页面。如果出现 `file_put_contents(...): Permission denied`，即为权限问题，按步骤 2 修复。修好后务必改回 `APP_DEBUG=false`。

2. **修复 IUSR 写权限**——见 [设置文件权限](#3-设置文件权限)。关键点：必须直接给 `IUSR` 授 `FullControl`，仅给 `IIS_IUSRS` 组的继承权限不够。

   ```powershell
   $paths = @(
       "C:\inetpub\wwwroot\nexopos\storage",
       "C:\inetpub\wwwroot\nexopos\bootstrap\cache"
   )
   foreach ($path in $paths) {
       $acl = Get-Acl $path
       $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
           "IUSR", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow"
       )
       $acl.AddAccessRule($rule)
       Set-Acl $path $acl
   }
   ```

3. **其他排查**:
   ```powershell
   # 检查 PHP 日志
   type "C:\PHP\logs\php_errors.log"

   # 检查 Laravel 日志
   type "C:\inetpub\wwwroot\nexopos\storage\logs\laravel.log"

   # 清除缓存
   php artisan cache:clear
   php artisan config:clear
   php artisan route:clear
   php artisan view:clear
   ```

### 2. CSRF Token 错误

**问题**: Token mismatch 错误

**解决方案**:
```powershell
# 确保 APP_URL 正确
# 编辑 .env
notepad "C:\inetpub\wwwroot\nexopos\.env"

# 设置正确的域名
APP_URL=http://your-domain.com

# 清除缓存
php artisan cache:clear
php artisan config:clear
```

### 3. 队列不工作

**问题**: 队列任务不执行

**解决方案**:
```powershell
# 检查服务状态
& "C:\nssm\nssm.exe" status NexoPOSQueueWorker

# 检查日志
type "C:\inetpub\wwwroot\nexopos\storage\logs\worker.log"

# 重启服务
& "C:\nssm\nssm.exe" restart NexoPOSQueueWorker

# 手动测试队列
php artisan queue:work --once
```

### 4. 模块资源 404

**问题**: 模块静态文件无法加载

**解决方案**:
```powershell
cd C:\inetpub\wwwroot\nexopos
php artisan modules:symlink
```

### 5. 上传文件失败

**问题**: 无法上传图片或文件

**解决方案**:
```powershell
# 检查存储链接
php artisan storage:link

# 检查权限
icacls "C:\inetpub\wwwroot\nexopos\storage\app\public"

# 检查 PHP 上传限制
php -r "echo ini_get('upload_max_filesize');"
php -r "echo ini_get('post_max_size');"
```

### 6. FastCGI 超时

**问题**: 请求超时

**解决方案**:
- 打开 **IIS 管理器**
- 选择 **NexoPOS Pool** 应用程序池
- 点击 **高级设置**
- **快速 CGI 超时**: `600`
- **请求超时**: `600`

### 7. `.bat` 脚本双击后闪一下就消失

**问题**: 双击 `sync-database.bat` 或其他 `.bat` 脚本，cmd 窗口一闪就关，看不到任何输出。

**根因**（三种情况，按此顺序检查）:

1. **行尾格式错误（LF vs CRLF）**
   如果脚本是在 Linux 环境编辑或由工具写入，行尾可能是 LF（Unix 格式）。Windows 的 `cmd.exe` 要求行尾为 CRLF（`\r\n`），否则整个文件当一行解析，所有命令都会报错。

   **检查方法**: 用记事本打开，看右下角是否显示 `LF`。如果是，切换为 `CRLF` 并保存。
   **命令行修复**: 在 PowerShell 中执行
   ```powershell
   $content = Get-Content "C:\inetpub\wwwroot\nexopos\scripts\sync-database.bat" -Raw
   $content -replace "`n", "`r`n" | Set-Content "C:\inetpub\wwwroot\nexopos\scripts\sync-database.bat" -NoNewline
   ```

2. **缺少管理员权限**
   脚本需要写入 `database/backups/` 目录。如果当前用户没有写权限，脚本会在写日志或创建目录时静默失败并退出。
   - 对脚本**右键 → 以管理员身份运行**
   - 或者在脚本开头加入自动提权逻辑（`sync-database.bat` 已包含）

3. **看不到错误信息时**
   用 `cmd /k` 启动脚本，窗口不会自动关闭：
   ```cmd
   cmd /k "C:\inetpub\wwwroot\nexopos\scripts\sync-database.bat"
   ```

### 8. `https://` 访问不到，`http://` 可以

**问题**: 浏览器访问 `https://localhost/` 报连接错误，但 `http://localhost/` 正常。

**根因**: IIS 站点没有绑定 HTTPS（443 端口）。默认创建站点只有 HTTP（80）绑定。

**解决方案**: 需要先获取 SSL 证书，再在 IIS 里添加 HTTPS 绑定。详细步骤见 [SSL/TLS 证书配置详细步骤](#ssltls-证书配置详细步骤)。

如果仅需本机调试用自签名证书：
```powershell
# 创建自签名证书
$cert = New-SelfSignedCertificate -DnsName "localhost" -CertStoreLocation "Cert:\LocalMachine\My"

# 在 IIS 管理器中：选择 NexoPOS 网站 → 绑定 → 添加
# 类型: https | 端口: 443 | SSL 证书: 选择上面创建的 localhost 证书
```

添加绑定后，同时需要将 `.env` 中的 `APP_URL` 更新为 `https://localhost`，并清除缓存：
```powershell
php artisan cache:clear
php artisan config:clear
```

---

## 维护和监控

### 1. 日志管理

#### 日志位置

```powershell
# PHP 日志
C:\PHP\logs\php_errors.log

# Laravel 应用日志
C:\inetpub\wwwroot\nexopos\storage\logs\laravel.log

# 队列日志
C:\inetpub\wwwroot\nexopos\storage\logs\worker.log

# Reverb 日志
C:\inetpub\wwwroot\nexopos\storage\logs\reverb.log
```

#### 日志轮转

创建 PowerShell 脚本 `C:\inetpub\wwwroot\nexopos\scripts\rotate-logs.ps1`：

```powershell
# 日志保留天数
$RetentionDays = 30

# 日志目录
$LogPath = "C:\inetpub\wwwroot\nexopos\storage\logs"

# 删除旧日志
Get-ChildItem $LogPath -Filter "*.log" |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$RetentionDays) } |
    Remove-Item -Force

Write-Output "Log rotation completed. Files older than $RetentionDays days have been deleted."
```

### 2. 系统监控

#### 监控队列服务

创建监控脚本 `C:\inetpub\wwwroot\nexopos\scripts\monitor-queue.ps1`：

```powershell
$serviceName = "NexoPOSQueueWorker"
$status = & "C:\nssm\nssm.exe" status $serviceName 2>&1

if ($status -like "*Stopped*") {
    Write-Output "Queue Worker is stopped. Starting..."
    & "C:\nssm\nssm.exe" start $serviceName

    # 发送通知（可选）
    # Send-MailMessage -To "admin@example.com" -Subject "NexoPOS Queue Worker Restarted"
} else {
    Write-Output "Queue Worker is running."
}
```

### 3. 性能监控

推荐工具：
- **Windows 性能监视器**（perfmon.msc）
- **IIS 日志**
- **MySQL Workbench** 性能仪表板

---

## 更新升级

### 升级到新版本

```powershell
cd C:\inetpub\wwwroot\nexopos

# 1. 备份当前版本
php artisan backup:run

# 2. 停止队列服务
& "C:\nssm\nssm.exe" stop NexoPOSQueueWorker"

# 3. 拉取最新代码
git pull origin v5.0.x

# 4. 安装依赖
composer install --no-dev --optimize-autoloader
npm install
npm run build

# 5. 运行迁移
php artisan migrate --force

# 6. 清除缓存
php artisan cache:clear
php artisan config:clear
php artisan route:clear

# 7. 重启队列服务
& "C:\nssm\nssm.exe" start NexoPOSQueueWorker

# 8. 重启 IIS
iisreset
```

---

## SSL/TLS 证书配置详细步骤

### 使用 IIS Express（开发环境）

### 使用 IIS（生产环境）

#### 获取商业 SSL 证书

1. **生成 CSR**
   ```powershell
   # 使用 OpenSSL
   openssl req -new -newkey rsa:2048 -nodes -keyout C:\nexopos.key -out C:\nexopos.csr

   # 或使用 IIS
   # 打开 IIS 管理器 → 服务器证书 → 创建证书申请
   ```

2. **提交 CA 申请**
   - 将 CSR 提交给证书颁发机构
   - 验证域名所有权
   - 下载证书文件

3. **安装证书**
   - 在 IIS 管理器中 **完成证书申请**
   - 或 **导入** 证书文件

#### 配置 HTTPS 绑定

1. **添加 HTTPS 绑定**
   - 选择 **NexoPOS** 网站
   - 点击 **绑定**
   - **添加**
   - 类型：`https`
   - 端口：`443`
   - SSL 证书：选择证书
   - 确定

2. **HTTP 到 HTTPS 重定向**
   - 安装 **URL 重写模块**（若尚未安装）
   - 将以下规则添加到已有的 `public/web.config` 的 `<rules>` 节点**最前面**（必须放在其他规则之前，否则先匹配到 rewrite 规则就不会执行重定向）：

   ```xml
   <rule name="HTTP to HTTPS redirect" stopProcessing="true">
       <match url="(.*)" />
       <conditions>
           <add input="{HTTPS}" pattern="off" ignoreCase="true" />
       </conditions>
       <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
   </rule>
   ```

   添加后 `public/web.config` 的 `<rules>` 节点顺序应为：

   ```xml
   <rules>
       <rule name="HTTP to HTTPS redirect" ...> <!-- 放在最前面 -->
       <rule name="Imported Rule 1" ...>        <!-- 末尾斜杠去除 -->
       <rule name="Imported Rule 2" ...>        <!-- Laravel 入口控制器 -->
   </rules>
   ```

---

## 配置所有服务开机自启

本章节汇总了所有必需服务的开机自启配置，确保 NexoPOS 在服务器重启后自动运行。

### 1. MySQL 服务

```powershell
# 设置 MySQL 服务为自动启动
Set-Service MySQL -StartupType Automatic

# 验证配置
Get-Service MySQL | Select-Object Name, StartType, Status

# 如果需要立即启动
Start-Service MySQL
```

### 2. Redis/Memurai 服务

```powershell
# 方法一：使用 NSSM（推荐）
nssm set Memurai Start SERVICE_AUTO_START

# 方法二：使用 Windows 服务命令
Set-Service Memurai -StartupType Automatic

# 验证配置
Get-Service Memurai | Select-Object Name, StartType, Status
```

### 3. IIS 相关服务

```powershell
# 确保 W3SVC 服务启动
Set-Service W3SVC -StartupType Automatic

# 确保 IIS Admin Service 启动
Set-Service IISADMIN -StartupType Automatic

# 验证配置
Get-Service W3SVC, IISADMIN | Select-Object Name, StartType, Status
```

### 4. NexoPOS 队列服务

```powershell
# 通过 NSSM 配置（已在"队列和计划任务"章节说明）
& "C:\nssm\nssm.exe" set NexoPOSQueueWorker Start SERVICE_AUTO_START

# 验证配置
& "C:\nssm\nssm.exe" status NexoPOSQueueWorker
```

### 5. NexoPOS Reverb 服务（可选）

```powershell
# 通过 NSSM 配置（已在"队列和计划任务"章节说明）
& "C:\nssm\nssm.exe" set NexoPOSReverb Start SERVICE_AUTO_START

# 验证配置
& "C:\nssm\nssm.exe" status NexoPOSReverb
```

### 6. 验证所有服务状态

创建验证脚本 `C:\inetpub\wwwroot\nexopos\scripts\check-services.ps1`：

```powershell
Write-Output "======================================"
Write-Output "NexoPOS Services Status Check"
Write-Output "======================================`n"

# MySQL
Write-Output "[1/6] MySQL Service..."
$mysql = Get-Service MySQL -ErrorAction SilentlyContinue
if ($mysql.Status -eq 'Running') {
    Write-Host "  ✓ MySQL is running" -ForegroundColor Green
} else {
    Write-Host "  ✗ MySQL is not running" -ForegroundColor Red
}

# Redis
Write-Output "[2/6] Redis/Memurai Service..."
$redis = Get-Service Memurai -ErrorAction SilentlyContinue
if ($redis.Status -eq 'Running') {
    Write-Host "  ✓ Redis is running" -ForegroundColor Green
} else {
    Write-Host "  ✗ Redis is not running" -ForegroundColor Red
}

# IIS
Write-Output "[3/6] IIS Service..."
$iis = Get-Service W3SVC -ErrorAction SilentlyContinue
if ($iis.Status -eq 'Running') {
    Write-Host "  ✓ IIS is running" -ForegroundColor Green
} else {
    Write-Host "  ✗ IIS is not running" -ForegroundColor Red
}

# NexoPOS Queue Worker
Write-Output "[4/6] NexoPOS Queue Worker..."
$queueStatus = & "C:\nssm\nssm.exe" status NexoPOSQueueWorker 2>&1
if ($queueStatus -like "*RUNNING*") {
    Write-Host "  ✓ Queue Worker is running" -ForegroundColor Green
} else {
    Write-Host "  ✗ Queue Worker is not running" -ForegroundColor Red
}

# NexoPOS Reverb（可选）
Write-Output "[5/6] NexoPOS Reverb Service..."
$reverbStatus = & "C:\nssm\nssm.exe" status NexoPOSReverb 2>&1
if ($reverbStatus -like "*RUNNING*") {
    Write-Host "  ✓ Reverb is running" -ForegroundColor Green
} else {
    Write-Host "  ! Reverb is not running (optional)" -ForegroundColor Yellow
}

# Task Scheduler
Write-Output "[6/6] Scheduled Tasks..."
$scheduler = Get-ScheduledTaskInfo "NexoPOS Scheduler" -ErrorAction SilentlyContinue
if ($scheduler) {
    Write-Host "  ✓ Scheduler is configured" -ForegroundColor Green
} else {
    Write-Host "  ✗ Scheduler is not configured" -ForegroundColor Red
}

Write-Output "`n======================================"
Write-Output "Status Check Completed"
Write-Output "======================================"

# 暂停以查看结果
Read-Host "Press Enter to exit"
```

运行验证脚本：

```powershell
C:\inetpub\wwwroot\nexopos\scripts\check-services.ps1
```

### 7. 创建完整的服务启动脚本

创建 `C:\inetpub\wwwroot\nexopos\scripts\start-all-services.ps1`：

```powershell
Write-Output "Starting NexoPOS services..."

# 启动 MySQL
Write-Output "Starting MySQL..."
Start-Service MySQL -ErrorAction SilentlyContinue

# 启动 Redis
Write-Output "Starting Redis..."
nssm start Memurai -ErrorAction SilentlyContinue

# 启动 IIS
Write-Output "Starting IIS..."
Start-Service W3SVC -ErrorAction SilentlyContinue

# 启动队列服务
Write-Output "Starting Queue Worker..."
& "C:\nssm\nssm.exe" start NexoPOSQueueWorker -ErrorAction SilentlyContinue

# 启动 Reverb（可选）
Write-Output "Starting Reverb..."
& "C:\nssm\nssm.exe" start NexoPOSReverb -ErrorAction SilentlyContinue

Write-Output "All services have been started."
```

### 8. 创建完整的服务停止脚本

创建 `C:\inetpub\wwwroot\nexopos\scripts\stop-all-services.ps1`：

```powershell
Write-Output "Stopping NexoPOS services..."

# 停止队列服务
Write-Output "Stopping Queue Worker..."
& "C:\nssm\nssm.exe" stop NexoPOSQueueWorker -ErrorAction SilentlyContinue

# 停止 Reverb
Write-Output "Stopping Reverb..."
& "C:\nssm\nssm.exe" stop NexoPOSReverb -ErrorAction SilentlyContinue

# 停止 IIS
Write-Output "Stopping IIS..."
Stop-Service W3SVC -ErrorAction SilentlyContinue

# 停止 Redis
Write-Output "Stopping Redis..."
nssm stop Memurai -ErrorAction SilentlyContinue

# 停止 MySQL（可选）
# Write-Output "Stopping MySQL..."
# Stop-Service MySQL -ErrorAction SilentlyContinue

Write-Output "All services have been stopped."
```

---

## 附录

### A. 常用命令速查

```powershell
# Laravel 命令
cd C:\inetpub\wwwroot\nexopos

# 数据库迁移
php artisan migrate:fresh --seed

# 清除缓存
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# 优化
php artisan config:cache
php artisan route:cache
php artisan view:compile

# 队列
php artisan queue:work --stop-when-empty
php artisan queue:retry

# 创建管理员
php artisan create:user

# IIS 重启
iisreset

# MySQL 服务
Restart-Service MySQL
```

### B. 目录权限配置

> PHP FastCGI 进程以 `IUSR` 身份运行。`IIS_IUSRS` 组的继承权限不一定能正确传递到子目录，必须直接给 `IUSR` 授 `FullControl`。详见 [设置文件权限](#3-设置文件权限)。

```powershell
# storage 和 bootstrap/cache 需要 IUSR 写入权限
# 如果仅给 IIS_IUSRS 或仅给 IUSR ReadAndExecute，会出现：
#   file_put_contents(...): Failed to open stream: Permission denied
# 导致页面 500 且响应体为空

$paths = @(
    "C:\inetpub\wwwroot\nexopos\storage",
    "C:\inetpub\wwwroot\nexopos\bootstrap\cache"
)
foreach ($path in $paths) {
    $acl = Get-Acl $path
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        "IUSR", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow"
    )
    $acl.AddAccessRule($rule)
    Set-Acl $path $acl
    Write-Host "OK: $path"
}
```

### C. Web.config 完整示例

项目已提供 `public/web.config`，如需自定义可参考以下完整示例。如果启用了 HTTPS，需在 `<rules>` 最前面添加 HTTPS 重定向规则（详见 [HTTP 到 HTTPS 重定向](#配置-httpstls) 段落）：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.webServer>
        <!-- 默认文档 -->
        <defaultDocument>
            <files>
                <add value="index.php" />
            </files>
        </defaultDocument>

        <!-- URL 重写 -->
        <rewrite>
            <rules>
                <!-- 如启用 HTTPS，将 HTTPS 重定向规则放在此处最前面 -->

                <!-- 规则1：去除末尾斜杠，301 重定向 /foo/ → /foo -->
                <rule name="Imported Rule 1" stopProcessing="true">
                    <match url="^(.*)/$" ignoreCase="false" />
                    <conditions>
                        <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" negate="true" />
                    </conditions>
                    <action type="Redirect" redirectType="Permanent" url="/{R:1}" />
                </rule>
                <!-- 规则2：非静态文件请求均转发到 Laravel 入口控制器 -->
                <rule name="Imported Rule 2" stopProcessing="true">
                    <match url="^(.*)$" ignoreCase="false" />
                    <conditions>
                        <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" negate="true" />
                        <add input="{REQUEST_FILENAME}" matchType="IsFile" ignoreCase="false" negate="true" />
                    </conditions>
                    <action type="Rewrite" url="index.php/{R:1}" appendQueryString="true" />
                </rule>
            </rules>
        </rewrite>

        <!-- 压缩 -->
        <urlCompression doStaticCompression="true" doDynamicCompression="true" />
        <staticContent>
            <mimeMap fileExtension=".json" mimeType="application/json" />
            <mimeMap fileExtension=".woff" mimeType="application/font-woff" />
            <mimeMap fileExtension=".woff2" mimeType="application/font-woff2" />
        </staticContent>

        <!-- HTTP 响应头 -->
        <httpProtocol>
            <customHeaders>
                <add name="X-Frame-Options" value="SAMEORIGIN" />
                <add name="X-Content-Type-Options" value="nosniff" />
                <add name="X-XSS-Protection" value="1; mode=block" />
            </customHeaders>
        </httpProtocol>
    </system.webServer>
</configuration>
```

### D. 官方资源

- **官方文档**: https://my.nexopos.com/en/documentation
- **API 文档**: https://docs.api.nexopos.com
- **视频教程**: https://www.youtube.com/watch?v=V80-hOJCywY
- **WhatsApp 社区**: https://chat.whatsapp.com/KHWgNmfcfJy7SwJiRQTmG8
- **GitHub**: https://github.com/blair2004/NexoPOS

### E. 获取支持

- **GitHub Issues**: https://github.com/blair2004/NexoPOS/issues
- **官方论坛**: https://my.nexopos.com/en/forums
- **付费支持**: https://my.nexopos.com/en/account/checkout/premium

---

## 许可证

NexoPOS 基于 MIT 许可证开源。
