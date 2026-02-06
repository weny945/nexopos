# NexoPOS 数据库备份与同步文档

## 概述

本文档描述了 NexoPOS 数据库自动备份和同步脚本的配置与使用方法。这些脚本提供了完整的数据库保护方案，包括自动备份、手动备份和数据库同步功能。

## 目录结构

```
scripts/
├── backup-database.bat      # Windows 自动备份脚本
├── backup-database.sh       # Linux 自动备份脚本
├── manual-backup.bat        # Windows 手动备份脚本
├── manual-backup.sh         # Linux 手动备份脚本
├── sync-database.bat        # Windows 数据库同步脚本
├── sync-database.sh         # Linux 数据库同步脚本
├── schedule-backup.bat      # Windows 计划任务设置脚本
├── schedule-backup.sh       # Linux 计划任务设置脚本
└── README.md                # 本文档

database/
├── backups/                 # 自动备份目录
│   └── backup.log           # 备份日志
└── sync-backups/            # 同步备份目录
    └── sync.log             # 同步日志
```

---

## 一、自动备份脚本

### 功能特性

- 自动备份 MySQL 数据库（包含结构、数据、存储过程、触发器、事件）
- 自动压缩备份文件（Linux/macOS 使用 gzip，Windows 可选 7-Zip）
- 自动清理超过保留期限的旧备份（默认 8 周）
- 详细的日志记录
- 支持自定义数据库连接参数

### 配置方法

#### Windows 配置

编辑 `backup-database.bat`，修改配置区域：

```batch
# 配置区域
SET "PROJECT_DIR=D:\develop\PHP_project\NexoPOS-master"
SET "BACKUP_DIR=%PROJECT_DIR%\database\backups"
SET "DB_HOST=127.0.0.1"
SET "DB_PORT=3306"
SET "DB_NAME=nexopos"
SET "DB_USER=root"
SET "DB_PASS=your_password"
SET "RETENTION_WEEKS=8"
```

#### Linux/macOS 配置

编辑 `backup-database.sh`，修改配置区域：

```bash
# 配置区域
PROJECT_DIR="/var/www/nexopos"
BACKUP_DIR="${PROJECT_DIR}/database/backups"
DB_HOST="127.0.0.1"
DB_PORT="3306"
DB_NAME="nexopos"
DB_USER="root"
DB_PASS="your_password"
RETENTION_WEEKS=8
```

### 使用方法

#### 手动执行备份

**Windows:**
```batch
cd D:\develop\PHP_project\NexoPOS-master\scripts
backup-database.bat
```

**Linux/macOS:**
```bash
cd /var/www/nexopos/scripts
chmod +x backup-database.sh
./backup-database.sh
```

#### 设置定时任务 (推荐)

**Windows:**
```batch
# 右键以管理员身份运行
schedule-backup.bat
```

默认设置：每周一凌晨 2:00 执行备份

**Linux/macOS:**
```bash
# 使用 root 权限运行
sudo ./schedule-backup.sh
```

默认设置：每周一凌晨 2:00 执行备份

### 备份文件命名格式

```
nexopos_YYYYMMDD_HHMMSS.sql          # 未压缩
nexopos_YYYYMMDD_HHMMSS.sql.gz       # Linux 压缩
nexopos_YYYYMMDD_HHMMSS.sql.zip      # Windows 压缩
```

示例：`nexopos_20250127_020000.sql.gz`

---

## 二、手动备份脚本

### 功能特性

- 交互式菜单操作
- 支持多种备份类型：
  - 完整备份（数据+结构+存储过程）
  - 仅结构备份
  - 仅数据备份
  - 自定义表备份
- 可选择是否压缩备份文件
- 显示备份文件大小

### 使用方法

**Windows:**
```batch
# 双击运行或在命令行执行
scripts\manual-backup.bat
```

**Linux/macOS:**
```bash
cd /var/www/nexopos/scripts
chmod +x manual-backup.sh
./manual-backup.sh
```

### 菜单选项

```
============================================
     NexoPOS 手动数据库备份工具
============================================

请选择备份类型:

  [1] 完整备份 (推荐) - 备份所有数据、结构、存储过程
  [2] 仅结构备份 - 只备份表结构，不含数据
  [3] 仅数据备份 - 只备份数据，不含结构
  [4] 自定义备份 - 选择特定表进行备份
  [5] 快速备份 - 使用默认设置直接备份

请输入选项 (1-5):
```

---

## 三、数据库同步脚本

### 功能特性

- 将源数据库完整复制到目标数据库
- 同步前自动备份目标数据库（防止误操作）
- 支持跳过或仅同步特定表
- 支持大数据库处理（临时文件或管道传输）
- 同步后验证数据一致性

### 使用场景

1. **开发环境同步**: 从生产环境同步数据到开发环境
2. **测试环境准备**: 创建测试数据副本
3. **数据迁移**: 在不同服务器间迁移数据
4. **灾难恢复**: 从备份恢复到新数据库

### 配置方法

编辑 `sync-database.bat` 或 `sync-database.sh`：

```bash
# 源数据库 (要从中复制数据的数据库)
SOURCE_HOST="127.0.0.1"
SOURCE_PORT="3306"
SOURCE_DB="nexopos_production"
SOURCE_USER="root"
SOURCE_PASS="production_password"

# 目标数据库 (要被覆盖的数据库)
TARGET_HOST="127.0.0.1"
TARGET_PORT="3306"
TARGET_DB="nexopos_dev"
TARGET_USER="root"
TARGET_PASS="dev_password"

# 同步选项
BACKUP_BEFORE_SYNC="YES"          # 同步前是否备份目标数据库
DROP_TABLES_FIRST="YES"           # 是否先删除目标数据库的表
SKIP_TABLES=""                    # 跳过的表 (逗号分隔)
ONLY_TABLES=""                    # 只同步特定表 (逗号分隔)
USE_TEMP_FILE="YES"               # 是否使用临时文件
```

### 使用方法

**Windows:**
```batch
cd D:\develop\PHP_project\NexoPOS-master\scripts
sync-database.bat
```

**Linux/macOS:**
```bash
cd /var/www/nexopos/scripts
chmod +x sync-database.sh
./sync-database.sh
```

### 高级用法

#### 跳过某些表

```bash
# 跳过日志表和临时表
SKIP_TABLES="ns_logs,ns_temp_sessions,ns_cache"
```

#### 仅同步特定表

```bash
# 只同步产品和订单表
ONLY_TABLES="ns_products,ns_orders,ns_order_products"
```

#### 大数据库同步

对于大型数据库，建议使用临时文件方式：

```bash
USE_TEMP_FILE="YES"  # 默认已设置
```

---

## 四、定时任务设置

### Windows 任务计划程序

#### 设置定时任务

1. 以管理员身份运行 `schedule-backup.bat`
2. 按照提示配置：
   - 默认：每周一凌晨 2:00
   - 可自定义时间和日期
3. 确认创建

#### 管理计划任务

```batch
# 查看任务
schtasks /Query /TN "NexoPOS_Weekly_Database_Backup"

# 立即运行
schtasks /Run /TN "NexoPOS_Weekly_Database_Backup"

# 删除任务
schtasks /Delete /TN "NexoPOS_Weekly_Database_Backup" /F

# 导出任务
schtasks /Query /XML /TN "NexoPOS_Weekly_Database_Backup" > backup_task.xml
```

#### 手动创建任务

如果自动化脚本失败，可以手动创建：

1. 打开"任务计划程序"（`taskschd.msc`）
2. 点击"创建基本任务"
3. 设置：
   - 名称：`NexoPOS_Weekly_Database_Backup`
   - 触发器：每周一 上午 2:00
   - 操作：启动程序
   - 程序：`D:\develop\PHP_project\NexoPOS-master\scripts\backup-database.bat`
4. 完成

### Linux Cron 定时任务

#### 设置定时任务

```bash
# 使用脚本自动设置
sudo ./schedule-backup.sh

# 或手动编辑 crontab
sudo crontab -e
```

#### Cron 表达式格式

```
# 格式: 分 时 日 月 周
# 示例: 每周一凌晨 2:00
0 2 * * 1 /var/www/nexopos/scripts/backup-database.sh >> /var/log/nexopos-backup.log 2>&1
```

#### 常用 Cron 表达式

```bash
# 每周一凌晨 2:00
0 2 * * 1 /path/to/backup-database.sh

# 每天凌晨 3:00
0 3 * * * /path/to/backup-database.sh

# 每月1号凌晨 1:00
0 1 1 * * /path/to/backup-database.sh

# 每6小时一次
0 */6 * * * /path/to/backup-database.sh

# 工作日晚上 11 点
0 23 * * 1-5 /path/to/backup-database.sh
```

#### 管理定时任务

```bash
# 查看当前任务
sudo crontab -l

# 编辑任务
sudo crontab -e

# 删除所有任务
sudo crontab -r

# 查看日志
sudo tail -f /var/log/nexopos-backup.log
```

---

## 五、日志和监控

### 日志文件位置

| 日志类型 | Windows 路径 | Linux 路径 |
|---------|-------------|-----------|
| 备份日志 | `database/backups/backup.log` | `/var/www/nexopos/database/backups/backup.log` |
| 同步日志 | `database/sync-backups/sync.log` | `/var/www/nexopos/database/sync-backups/sync.log` |
| Cron 日志 | - | `/var/log/nexopos-backup.log` |

### 日志内容示例

```
================================
备份开始时间: 2025-01-27 02:00:00
数据库: nexopos

正在备份数据库...
使用 MySQL 路径: C:\Program Files\MySQL\MySQL Server 8.0\bin\
备份成功: D:\develop\PHP_project\nexopos\database\backups\nexopos_20250127_020000.sql
正在压缩备份文件...
压缩成功: D:\develop\PHP_project\nexopos\database\backups\nexopos_20250127_020000.sql.zip
备份文件大小: 15 MB

正在清理 8 周前的旧备份...
旧备份清理完成

当前备份文件列表:
  nexopos_20250127_020000.sql.zip (15 MB)
  nexopos_20250120_020000.sql.zip (14 MB)
  nexopos_20250113_020000.sql.zip (14 MB)

备份完成时间: 2025-01-27 02:05:30
================================
```

### 监控建议

1. **定期检查日志**：每周检查备份日志，确保备份成功
2. **设置告警**：可以使用监控工具（如 Nagios、Zabbix）监控备份目录
3. **测试恢复**：每月测试一次备份恢复流程
4. **磁盘空间监控**：确保备份目录有足够空间

---

## 六、数据恢复

### 从备份恢复数据库

#### Windows

```batch
REM 解压备份文件（如果已压缩）
"C:\Program Files\7-Zip\7z.exe" x nexopos_20250127_020000.sql.zip

REM 恢复数据库
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --host=127.0.0.1 --user=root --password nexopos < nexopos_20250127_020000.sql
```

#### Linux

```bash
# 解压备份文件
gunzip nexopos_20250127_020000.sql.gz

# 恢复数据库
mysql --host=127.0.0.1 --user=root --password nexopos < nexopos_20250127_020000.sql
```

### 恢复注意事项

1. 恢复前先备份当前数据库
2. 确保目标数据库存在
3. 大型数据库恢复可能需要较长时间
4. 恢复期间应用程序应暂停访问

---

## 七、最佳实践

### 备份策略

1. **备份频率**：
   - 生产环境：每天至少备份一次
   - 开发环境：每周备份一次
   - 重要更新前：手动备份

2. **保留策略**：
   - 保留最近 4 周的每日备份
   - 保留最近 6 个月的每周备份
   - 保留最近 2 年的每月备份

3. **备份存储**：
   - 本地备份：快速恢复
   - 远程备份：灾难恢复
   - 云存储：长期归档

### 安全建议

1. **保护敏感信息**：
   - 不要将密码硬编码在脚本中
   - 使用环境变量或配置文件
   - 设置适当的文件权限（Linux: 600）

2. **加密备份**：
   - 敏感数据备份应加密
   - 使用 GPG 或其他加密工具

3. **访问控制**：
   - 限制备份目录访问权限
   - 定期审计备份访问日志

### 测试恢复

定期测试备份恢复流程：

```bash
# 1. 创建测试数据库
mysql -u root -p -e "CREATE DATABASE nexopos_test;"

# 2. 恢复备份到测试数据库
mysql -u root -p nexopos_test < backup.sql

# 3. 验证数据完整性
mysql -u root -p nexopos_test -e "SELECT COUNT(*) FROM ns_orders;"

# 4. 对比数据
diff <(mysql -u root -p nexopos -N -e "SELECT COUNT(*) FROM ns_orders") \
     <(mysql -u root -p nexopos_test -N -e "SELECT COUNT(*) FROM ns_orders;")
```

---

## 八、故障排查

### 常见问题

#### 1. 找不到 mysqldump 命令

**Windows:**
```batch
# 查找 mysqldump 位置
where mysqldump

# 添加到系统 PATH
setx PATH "%PATH%;C:\Program Files\MySQL\MySQL Server 8.0\bin"
```

**Linux:**
```bash
# 安装 MySQL 客户端
sudo apt-get install mysql-client  # Debian/Ubuntu
sudo yum install mysql             # CentOS/RHEL

# 或创建符号链接
sudo ln -s /usr/local/mysql/bin/mysqldump /usr/local/bin/mysqldump
```

#### 2. 权限不足

```bash
# 确保用户有备份权限
GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER ON nexopos.* TO 'backup_user'@'localhost';

# 刷新权限
FLUSH PRIVILEGES;
```

#### 3. 磁盘空间不足

```bash
# 检查磁盘空间
df -h

# 清理旧备份
find database/backups -name "*.sql*" -mtime +60 -delete

# 或修改保留策略
# 编辑脚本，设置 RETENTION_WEEKS=4
```

#### 4. 定时任务未执行

**Windows:**
```batch
# 检查任务计划程序服务
sc query Schedule

# 查看任务历史
schtasks /Query /V /TN "NexoPOS_Weekly_Database_Backup" /FO LIST
```

**Linux:**
```bash
# 检查 cron 服务
sudo systemctl status cron

# 查看 cron 日志
sudo grep CRON /var/log/syslog

# 验证脚本可执行
ls -l /var/www/nexopos/scripts/backup-database.sh
```

---

## 九、扩展功能

### 远程备份

```bash
# 备份到远程服务器
mysqldump nexopos | ssh user@remote "cat > /backups/nexopos_$(date +%Y%m%d).sql"

# 使用 rsync 同步备份目录
rsync -avz --delete database/backups/ user@remote:/backups/nexopos/
```

### 云备份

```bash
# 备份到 AWS S3
aws s3 cp database/backups/nexopos_$(date +%Y%m%d).sql.gz s3://my-backup-bucket/nexopos/

# 备份到 Google Cloud Storage
gsutil cp database/backups/nexopos_$(date +%Y%m%d).sql.gz gs://my-backup-bucket/nexopos/
```

### 邮件通知

在脚本末尾添加邮件通知功能：

```bash
# 发送备份结果邮件
if [ $BACKUP_SUCCESS -eq 1 ]; then
    echo "数据库备份成功: ${BACKUP_FILE}" | mail -s "NexoPOS 备份成功" admin@example.com
else
    echo "数据库备份失败，请查看日志: ${LOG_FILE}" | mail -s "NexoPOS 备份失败" admin@example.com
fi
```

---

## 十、快速参考

### Windows 常用命令

| 操作 | 命令 |
|-----|-----|
| 手动备份 | `scripts\backup-database.bat` |
| 交互式备份 | `scripts\manual-backup.bat` |
| 设置定时任务 | `scripts\schedule-backup.bat` (管理员) |
| 数据库同步 | `scripts\sync-database.bat` |
| 查看计划任务 | `schtasks /Query /TN "NexoPOS_Weekly_Database_Backup"` |
| 立即执行任务 | `schtasks /Run /TN "NexoPOS_Weekly_Database_Backup"` |

### Linux 常用命令

| 操作 | 命令 |
|-----|-----|
| 手动备份 | `./scripts/backup-database.sh` |
| 交互式备份 | `./scripts/manual-backup.sh` |
| 设置定时任务 | `sudo ./scripts/schedule-backup.sh` |
| 数据库同步 | `./scripts/sync-database.sh` |
| 查看 cron 任务 | `sudo crontab -l` |
| 编辑 cron 任务 | `sudo crontab -e` |
| 查看备份日志 | `tail -f database/backups/backup.log` |

---

## 更新日志

| 版本 | 日期 | 说明 |
|-----|------|------|
| 1.0 | 2025-01-27 | 初始版本，支持自动备份、手动备份、数据库同步 |

---

## 技术支持

如有问题，请参考：
- NexoPOS 官方文档：https://my.nexopos.com/en/documentation
- MySQL 官方文档：https://dev.mysql.com/doc/

---

**注意**：使用前请在测试环境中验证所有脚本，确保符合您的需求和环境配置。
