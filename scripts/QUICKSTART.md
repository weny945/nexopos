# 数据库备份快速入门

## 快速开始 (3 步设置)

### Windows 环境

#### 步骤 1: 配置数据库连接

编辑 `scripts\backup-database.bat`，修改第 8-14 行：

```batch
SET "PROJECT_DIR=D:\develop\PHP_project\NexoPOS-master"
SET "DB_HOST=127.0.0.1"
SET "DB_PORT=3306"
SET "DB_NAME=nexopos"
SET "DB_USER=root"
SET "DB_PASS=your_password"
```

#### 步骤 2: 设置定时任务

右键 `scripts\schedule-backup.bat`，选择"以管理员身份运行"

按提示完成配置（默认：每周一凌晨 2:00）

#### 步骤 3: 验证

```batch
cd scripts
backup-database.bat
```

检查 `database\backups\` 目录，确认备份文件已生成。

---

### Linux 环境

#### 步骤 1: 配置数据库连接

编辑 `scripts/backup-database.sh`，修改第 8-14 行：

```bash
PROJECT_DIR="/var/www/nexopos"
DB_HOST="127.0.0.1"
DB_PORT="3306"
DB_NAME="nexopos"
DB_USER="root"
DB_PASS="your_password"
```

#### 步骤 2: 设置定时任务

```bash
cd /var/www/nexopos/scripts
sudo ./schedule-backup.sh
```

按提示完成配置（默认：每周一凌晨 2:00）

#### 步骤 3: 验证

```bash
./backup-database.sh
ls -lh database/backups/
```

---

## 常用命令速查

### Windows

```batch
# 立即执行备份
scripts\backup-database.bat

# 交互式手动备份（多种选项）
scripts\manual-backup.bat

# 数据库同步（生产 -> 开发）
scripts\sync-database.bat

# 查看计划任务
schtasks /Query /TN "NexoPOS_Weekly_Database_Backup"

# 立即执行任务
schtasks /Run /TN "NexoPOS_Weekly_Database_Backup"
```

### Linux

```bash
# 立即执行备份
./scripts/backup-database.sh

# 交互式手动备份（多种选项）
./scripts/manual-backup.sh

# 数据库同步（生产 -> 开发）
./scripts/sync-database.sh

# 查看 cron 任务
sudo crontab -l

# 查看备份日志
tail -f database/backups/backup.log
```

---

## 数据恢复

### Windows

```batch
REM 1. 解压备份
"C:\Program Files\7-Zip\7z.exe" x database\backups\nexopos_20250127.sql.zip

REM 2. 恢复到数据库
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --user=root --password nexopos < nexopos_20250127.sql
```

### Linux

```bash
# 1. 解压备份
gunzip database/backups/nexopos_20250127.sql.gz

# 2. 恢复到数据库
mysql --user=root --password nexopos < database/backups/nexopos_20250127.sql
```

---

## 故障排查

### 找不到 mysqldump

**Windows:** 添加 MySQL 到系统 PATH
```batch
setx PATH "%PATH%;C:\Program Files\MySQL\MySQL Server 8.0\bin"
```

**Linux:** 安装 MySQL 客户端
```bash
sudo apt-get install mysql-client
```

### 定时任务未执行

**Windows:** 检查任务计划程序服务
```batch
sc query Schedule
```

**Linux:** 检查 cron 服务和日志
```bash
sudo systemctl status cron
sudo grep CRON /var/log/syslog
```

---

## 文件说明

| 文件 | 用途 |
|-----|------|
| `backup-database.bat/sh` | 自动备份脚本（定时任务使用）|
| `manual-backup.bat/sh` | 手动备份脚本（交互式菜单）|
| `sync-database.bat/sh` | 数据库同步脚本 |
| `schedule-backup.bat/sh` | 一键设置定时任务 |
| `README.md` | 完整文档 |

---

## 下一步

- 阅读完整文档：`scripts/README.md`
- 定期检查备份日志：`database/backups/backup.log`
- 测试数据恢复流程
- 配置远程备份（异地容灾）
