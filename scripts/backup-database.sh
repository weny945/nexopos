#!/bin/bash
# ============================================================
# NexoPOS 数据库自动备份脚本 (Linux/macOS)
# 功能：备份 MySQL 数据库，保留最近 8 周的备份
# 计划：每周一凌晨 2:00 执行
# ============================================================

# 配置区域 - 根据实际情况修改
PROJECT_DIR="/var/www/nexopos"
BACKUP_DIR="${PROJECT_DIR}/database/backups"
DB_HOST="127.0.0.1"
DB_PORT="3306"
DB_NAME="nexopos"
DB_USER="root"
DB_PASS="your_password"
DB_PREFIX="ns_"
RETENTION_WEEKS=8

# 日志文件
LOG_FILE="${BACKUP_DIR}/backup.log"

# 时间戳: YYYYMMDD_HHMMSS
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# 创建备份目录（如果不存在）
mkdir -p "${BACKUP_DIR}"

# 开始日志记录
echo "================================" >> "${LOG_FILE}"
echo "备份开始时间: $(date '+%Y-%m-%d %H:%M:%S')" >> "${LOG_FILE}"
echo "数据库: ${DB_NAME}" >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

# 备份文件名
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"

# ============================================================
# 使用 mysqldump 备份
# ============================================================
echo "正在备份数据库..." >> "${LOG_FILE}"

# 检查 mysqldump 是否可用
if ! command -v mysqldump &> /dev/null; then
    echo "错误: 未找到 mysqldump 命令，请安装 MySQL 客户端" >> "${LOG_FILE}"
    echo "安装命令: sudo apt-get install mysql-client 或 yum install mysql" >> "${LOG_FILE}"
    exit 1
fi

# 执行备份
mysqldump --host="${DB_HOST}" \
          --port="${DB_PORT}" \
          --user="${DB_USER}" \
          --password="${DB_PASS}" \
          --single-transaction \
          --routines \
          --triggers \
          --events \
          "${DB_NAME}" > "${BACKUP_FILE}" 2>> "${LOG_FILE}"

if [ $? -eq 0 ]; then
    echo "备份成功: ${BACKUP_FILE}" >> "${LOG_FILE}"

    # 压缩备份文件
    echo "正在压缩备份文件..." >> "${LOG_FILE}"
    gzip "${BACKUP_FILE}"

    if [ $? -eq 0 ]; then
        BACKUP_FILE="${BACKUP_FILE}.gz"
        echo "压缩成功: ${BACKUP_FILE}" >> "${LOG_FILE}"

        # 获取文件大小
        FILE_SIZE=$(du -h "${BACKUP_FILE}" | cut -f1)
        echo "备份文件大小: ${FILE_SIZE}" >> "${LOG_FILE}"
    else
        echo "警告: 压缩失败，保留未压缩文件" >> "${LOG_FILE}"
    fi
else
    echo "错误: mysqldump 执行失败" >> "${LOG_FILE}"
    exit 1
fi

# ============================================================
# 清理旧备份 (保留最近 N 周)
# ============================================================
echo "" >> "${LOG_FILE}"
echo "正在清理 ${RETENTION_WEEKS} 周前的旧备份..." >> "${LOG_FILE}"

# 删除超过保留期的备份文件
find "${BACKUP_DIR}" -name "${DB_NAME}_*.sql*" -type f -mtime +$((RETENTION_WEEKS * 7)) -delete >> "${LOG_FILE}" 2>&1

if [ $? -eq 0 ]; then
    echo "旧备份清理完成" >> "${LOG_FILE}"
else
    echo "警告: 清理旧备份时出错" >> "${LOG_FILE}"
fi

# ============================================================
# 备份统计信息
# ============================================================
echo "" >> "${LOG_FILE}"
echo "当前备份文件列表:" >> "${LOG_FILE}"
ls -lh "${BACKUP_DIR}"/${DB_NAME}_*.sql* 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}' >> "${LOG_FILE}" || echo "  无备份文件" >> "${LOG_FILE}"

# 计算总备份大小
TOTAL_SIZE=$(du -sh "${BACKUP_DIR}" 2>/dev/null | cut -f1)
echo "备份目录总大小: ${TOTAL_SIZE}" >> "${LOG_FILE}"

# 完成
echo "" >> "${LOG_FILE}"
echo "备份完成时间: $(date '+%Y-%m-%d %H:%M:%S')" >> "${LOG_FILE}"
echo "================================" >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

# 显示结果
echo "数据库备份完成！"
echo "备份文件: ${BACKUP_FILE}"
echo "查看日志: ${LOG_FILE}"

exit 0
