# NexoPOS 生产环境部署指南

## 目录

- [系统要求](#系统要求)
- [部署前准备](#部署前准备)
- [生产环境部署](#生产环境部署)
- [数据库配置](#数据库配置)
- [环境变量配置](#环境变量配置)
- [文件权限设置](#文件权限设置)
- [Web 服务器配置](#web-服务器配置)
- [队列和任务调度](#队列和任务调度)
- [性能优化](#性能优化)
- [安全加固](#安全加固)
- [备份策略](#备份策略)
- [故障排查](#故障排查)

---

## 系统要求

### 最低要求

- **PHP**: 8.2 或更高版本
- **MySQL/MariaDB**: 5.7+ / 10.3+
- **Web 服务器**: Apache (mod_rewrite) 或 Nginx
- **Node.js**: 18.0+ (用于构建前端资源)
- **npm**: 9.0+
- **Composer**: 2.0+
- **内存**: 最低 512MB，推荐 1GB+
- **磁盘空间**: 最低 500MB 可用空间

### 推荐配置

- **PHP**: 8.2
- **MySQL**: 8.0+
- **Redis**: 6.0+ (用于队列和缓存)
- **内存**: 2GB+
- **CPU**: 2 核心以上

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
- PCRE
- PDO
- PDO MySQL
- Tokenizer
- XML
- Zip
- GD 或 ImageMagick

---

## 部署前准备

### 1. 服务器准备

#### Ubuntu/Debian

```bash
# 更新系统
sudo apt update && sudo apt upgrade -y

# 安装必要的软件包
sudo apt install -y git curl unzip wget \
    nginx mysql-server redis-server \
    php8.2-fpm php8.2-mysql php8.2-xml php8.2-mbstring \
    php8.2-curl php8.2-zip php8.2-bcmath php8.2-gd \
    php8.2-json php8.2-cli composer nodejs npm

# 安装 Supervisor (用于队列进程)
sudo apt install -y supervisor
```

#### CentOS/RHEL

```bash
# 更新系统
sudo yum update -y

# 安装必要的软件包
sudo yum install -y git curl unzip wget \
    nginx mysql-server redis \
    php82-php-fpm php82-php-mysqlnd php82-php-xml \
    php82-php-mbstring php82-php-curl php82-php-bcmath \
    php82-php-gd composer nodejs npm

# 安装 Supervisor
sudo yum install -y supervisor
```

### 2. 克隆项目

```bash
# 克隆仓库（或上传您的项目文件）
cd /var/www
git clone https://github.com/blair2004/NexoPOS.git nexopos
cd nexopos

# 如果使用分支
git checkout v5.0.x
```

### 3. 设置文件权限

```bash
# 设置目录所有者
sudo chown -R www-data:www-data /var/www/nexopos

# 设置基本权限
sudo chmod -R 755 /var/www/nexopos
```

---

## 生产环境部署

### 步骤 1: 安装依赖

```bash
cd /var/www/nexopos

# 安装 PHP 依赖
composer install --no-dev --optimize-autoloader

# 安装前端依赖
npm install

# 构建前端资源
npm run build
```

### 步骤 2: 环境配置

```bash
# 复制环境配置文件
cp .env.example .env

# 生成应用密钥
php artisan key:generate

# 编辑 .env 文件
nano .env
```

### 步骤 3: 数据库设置

```bash
# 创建数据库（如果还没创建）
mysql -u root -p

CREATE DATABASE nexopos_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'nexopos_user'@'localhost' IDENTIFIED BY 'your_strong_password';
GRANT ALL PRIVILEGES ON nexopos_db.* TO 'nexopos_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 步骤 4: 配置 .env 文件

编辑 `.env` 文件，设置以下关键参数：

```ini
APP_NAME="NexoPOS"
APP_ENV=production
APP_KEY=base64:generated_key
APP_DEBUG=false
APP_URL=https://your-domain.com

# 数据库配置
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=nexopos_db
DB_USERNAME=nexopos_user
DB_PASSWORD=your_strong_password
DB_PREFIX=ns_

# Redis 配置（推荐用于生产环境）
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis

# 广播配置（可选，用于实时功能）
BROADCAST_DRIVER=reverb
REVERB_APP_ID=your_app_id
REVERB_APP_KEY=your_app_key
REVERB_APP_SECRET=your_app_secret

# 队列配置
QUEUE_CONNECTION=redis
```

### 步骤 5: 运行安装

```bash
# 创建符号链接
php artisan storage:link

# 创建语言文件符号链接
php artisan ns:translate --symlink --force

# 创建模块符号链接
php artisan modules:symlink

# 运行数据库迁移
php artisan migrate --force

# 清除缓存
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# 优化配置
php artisan config:cache
php artisan route:cache
php artisan view:compile
```

---

## 数据库配置

### MySQL 优化配置

编辑 `/etc/mysql/my.cnf` (Ubuntu) 或 `/etc/my.cnf` (CentOS)：

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
```

重启 MySQL：

```bash
sudo systemctl restart mysql
```

---

## 环境变量配置

### 生产环境关键配置

```ini
# 应用配置
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-domain.com

# 时区设置
APP_TIMEZONE=Asia/Shanghai

# 数据库前缀
DB_PREFIX=ns_
```

---

## 文件权限设置

### 设置正确的文件权限

```bash
cd /var/www/nexopos

# storage 和 bootstrap 缓存目录可写
sudo chmod -R 775 storage bootstrap/cache

# 或者更宽松的权限（如果需要）
sudo chmod -R 777 storage bootstrap/cache

# 确保所有者正确
sudo chown -R www-data:www-data storage bootstrap/cache
```

### SELinux 配置（如果启用）

```bash
# 允许 Apache/Nginx 写入存储目录
sudo chcon -R -t httpd_sys_rw_content_t storage

# 允许 Apache/Nginx 写入 bootstrap/cache
sudo chcon -R -t httpd_sys_rw_content_t bootstrap/cache
```

---

## Web 服务器配置

### Nginx 配置

创建配置文件 `/etc/nginx/sites-available/nexopos`：

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name your-domain.com www.your-domain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name your-domain.com www.your-domain.com;
    root /var/www/nexopos/public;

    # SSL 证书配置
    ssl_certificate /etc/ssl/certs/your-domain.crt;
    ssl_certificate_key /etc/ssl/private/your-domain.key;

    index index.php index.html;

    # 日志
    access_log /var/log/nginx/nexopos-access.log;
    error_log /var/log/nginx/nexopos-error.log;

    # 客户端上传大小限制
    client_max_body_size 100M;

    # Gzip 压缩
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript
               application/x-javascript application/xml+rss
               application/json application/javascript;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # 拒绝访问隐藏文件
    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }

    # PHP-FPM 配置
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_buffer_size 128k;
        fastcgi_buffers 4 256k;
        fastcgi_busy_buffers_size 256k;
    }

    # 静态资源缓存
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
}
```

启用站点：

```bash
# 创建符号链接
sudo ln -s /etc/nginx/sites-available/nexopos /etc/nginx/sites-enabled/

# 测试配置
sudo nginx -t

# 重启 Nginx
sudo systemctl restart nginx
```

### Apache 配置

创建 `.htaccess` 文件（已包含在项目中）：

```apache
<IfModule mod_rewrite.c>
    <IfModule mod_negotiation.c>
        Options -MultiViews -Indexes
    </IfModule>

    RewriteEngine On

    # Handle Authorization Header
    RewriteCond %{HTTP:Authorization} .
    RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]

    # Redirect Trailing Slashes If Not A Folder
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_URI} (.+)/$
    RewriteRule ^ %1 [L,R=301]

    # Send Requests To Front Controller
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [L]
</IfModule>
```

创建虚拟主机配置 `/etc/apache2/sites-available/nexopos.conf`：

```apache
<VirtualHost *:443>
    ServerName your-domain.com
    ServerAlias www.your-domain.com
    DocumentRoot /var/www/nexopos/public

    <Directory /var/www/nexopos/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/nexopos-error.log
    CustomLog ${APACHE_LOG_DIR}/nexopos-access.log combined

    # SSL 配置
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/your-domain.crt
    SSLCertificateKeyFile /etc/ssl/private/your-domain.key

    # 上传大小限制
    LimitRequestBody 104857600
</VirtualHost>

# HTTP 到 HTTPS 重定向
<VirtualHost *:80>
    ServerName your-domain.com
    Redirect permanent / https://your-domain.com/
</VirtualHost>
```

启用站点：

```bash
sudo a2ensite nexopos.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

---

## 队列和任务调度

### 配置队列 Worker

使用 Supervisor 管理队列进程：

创建配置文件 `/etc/supervisor/conf.d/nexopos-worker.conf`：

```ini
[program:nexopos-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /var/www/nexopos/artisan queue:work --sleep=3 --tries=3 --max-time=3600
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
user=www-data
numprocs=2
redirect_stderr=true
stdout_logfile=/var/www/nexopos/storage/logs/worker.log
stopwaitsecs=3600
```

重启 Supervisor：

```bash
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start nexopos-worker:*
```

### 配置定时任务

添加到 crontab：

```bash
sudo crontab -e -u www-data
```

添加以下行：

```cron
* * * * * cd /var/www/nexopos && php artisan schedule:run >> /dev/null 2>&1
```

### 配置 WebSocket（可选）

如果要使用实时功能（Reverb）：

创建 Systemd 服务 `/etc/systemd/system/reverb.service`：

```ini
[Unit]
Description=NexoPOS Reverb Server
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/var/www/nexopos
ExecStart=/usr/bin/php /var/www/nexopos/artisan reverb:start
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

启动服务：

```bash
sudo systemctl daemon-reload
sudo systemctl enable reverv
sudo systemctl start reverv
```

---

## 性能优化

### 1. OPcache 配置

编辑 `/etc/php/8.2/fpm/php.ini`：

```ini
# OPcache 配置
opcache.enable=1
opcache.memory_consumption=256
opcache.interned_strings_buffer=16
opcache.max_accelerated_files=10000
opcache.revalidate_freq=60
opcache.fast_shutdown=1
opcache.enable_cli=1
```

### 2. Redis 配置

编辑 `/etc/redis/redis.conf`：

```ini
# 内存配置
maxmemory 256mb
maxmemory-policy allkeys-lru

# 持久化
save 900 1
save 300 10
save 60 10000

# 日志
loglevel notice
logfile /var/log/redis/redis-server.log
```

### 3. 应用缓存优化

```bash
# 缓存配置、路由和视图
php artisan config:cache
php artisan route:cache
php artisan view:compile

# 预热缓存
php artisan cache:warm
```

### 4. 数据库优化

```bash
# 优化数据库表
php artisan db:optimize
```

---

## 安全加固

### 1. SSL/TLS 证书

#### 使用 Let's Encrypt（免费）

```bash
# 安装 Certbot
sudo apt install certbot python3-certbot-nginx

# 获取证书
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# 自动续期
sudo certbot renew --dry-run
```

### 2. 防火墙配置

```bash
# UFW 防火墙
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw status
```

### 3. 禁用函数（可选）

编辑 `/etc/php/8.2/fpm/php.ini`：

```ini
disable_functions = exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source
```

### 4. 文件上传限制

```ini
# php.ini
upload_max_filesize = 100M
post_max_size = 100M
memory_limit = 256M
max_execution_time = 300
```

---

## 备份策略

### 自动备份设置

使用项目提供的备份脚本（详见 `scripts/README.md`）：

```bash
cd /var/www/nexopos/scripts

# 配置备份参数（编辑 backup-database.sh）
nano backup-database.sh

# 测试备份
./backup-database.sh

# 设置定时备份
crontab -e
```

添加定时任务（每天凌晨 2 点备份）：

```cron
0 2 * * * /var/www/nexopos/scripts/backup-database.sh
```

### 完整备份策略

#### 每日备份
- 数据库完整备份
- 保留 8 周

#### 每周备份
- 上传的文件和图片
- 保留 12 周

#### 每月备份
- 完整系统备份（代码 + 数据库 + 上传文件）
- 永久保留

#### 备份存储位置
```bash
/var/www/nexopos/database/backups/    # 数据库备份
/var/www/nexopos/storage/app/backups/  # 应用备份
```

---

## 故障排查

### 1. CSRF Token 错误

**问题**: Token mismatch 错误

**解决方案**:
```bash
# 确保 APP_URL 正确
nano .env
# APP_URL=https://your-domain.com

# 清除缓存
php artisan cache:clear
php artisan config:clear
```

### 2. 无限加载

**问题**: 页面一直加载

**解决方案**:
```bash
# 检查数据库连接
php artisan tinker
>>> \DB::connection()->getPdo();
>>> exit

# 检查 storage 权限
sudo chmod -R 775 storage bootstrap/cache
```

### 3. 队列不工作

**问题**: 队列任务不执行

**解决方案**:
```bash
# 检查 Supervisor 状态
sudo supervisorctl status

# 查看队列日志
tail -f /var/www/nexopos/storage/logs/worker.log

# 重启队列
sudo supervisorctl restart nexopos-worker:*
```

### 4. 模块资源 404

**问题**: 模块静态文件无法加载

**解决方案**:
```bash
php artisan modules:symlink
```

### 5. 上传文件失败

**问题**: 无法上传图片或文件

**解决方案**:
```bash
# 检查存储链接
php artisan storage:link

# 检查权限
sudo chmod -R 775 storage/public/uploads

# 检查 PHP 上传限制
php -i | grep upload_max_filesize
```

---

## 监控和维护

### 日志位置

```bash
/var/www/nexopos/storage/logs/
├── laravel.log          # 应用日志
├── worker.log           # 队列日志
└── backup.log           # 备份日志
```

### 日志轮转

创建 `/etc/logrotate.d/nexopos`：

```
/var/www/nexopos/storage/logs/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 www-data www-data
}
```

### 性能监控

推荐工具：
- **New Relic** - 应用性能监控
- **Sentry** - 错误追踪
- **Laravel Telescope** - 本地开发调试（生产环境禁用）

---

## 更新升级

### 升级到新版本

```bash
cd /var/www/nexopos

# 备份当前版本
php artisan backup:run

# 拉取最新代码
git pull origin v5.0.x

# 安装依赖
composer install --no-dev --optimize-autoloader
npm install
npm run build

# 运行迁移
php artisan migrate --force

# 清除缓存
php artisan cache:clear
php artisan config:clear
php artisan route:clear

# 重启队列
sudo supervisorctl restart nexopos-worker:*
```

---

## DigitalOcean 一键部署

NexoPOS 提供 DigitalOcean App Platform 的一键部署选项：

1. 访问 [NexoPOS on DigitalOcean](https://cloud.digitalocean.com/apps/new?repo=https://github.com/blair2004/NexoPOS/tree/v5.0.x&refcode=ebdb80cb0ec7)
2. 点击 "Deploy to DO" 按钮
3. 配置区域、数据库和其他设置
4. 点击 "Deploy"

部署配置模板位于 `.do/deploy.template.yaml`。

---

## 官方资源

- **官方文档**: https://my.nexopos.com/en/documentation
- **API 文档**: https://docs.api.nexopos.com
- **视频教程**: https://www.youtube.com/watch?v=V80-hOJCywY
- **WhatsApp 社区**: https://chat.whatsapp.com/KHWgNmfcfJy7SwJiRQTmG8
- **GitHub**: https://github.com/blair2004/NexoPOS

---

## 获取支持

### 免费支持
- GitHub Issues
- 官方文档
- 社区论坛

### 付费支持
- [My NexoPOS Premium](https://my.nexopos.com/en/account/checkout/premium)
- CodeCanyon 购买者专属支持
- 定制开发服务

---

## 许可证

NexoPOS 基于 MIT 许可证开源。详见 [LICENSE](https://github.com/blair2004/NexoPOS/blob/master/LICENSE.md) 文件。
