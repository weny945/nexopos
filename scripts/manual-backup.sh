#!/bin/bash
# ============================================================
# NexoPOS 手动数据库备份脚本 (Linux/macOS)
# 功能：手动触发数据库备份，带交互式选项
# 使用: ./manual-backup.sh
# ============================================================

# 配置区域
PROJECT_DIR="/var/www/nexopos"
BACKUP_DIR="${PROJECT_DIR}/database/backups"
DB_HOST="127.0.0.1"
DB_PORT="3306"
DB_NAME="nexopos"
DB_USER="root"
DB_PASS="your_password"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示标题
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}     NexoPOS 手动数据库备份工具${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo "当前配置:"
echo "  数据库: ${DB_NAME}"
echo "  主机:   ${DB_HOST}:${DB_PORT}"
echo "  备份目录: ${BACKUP_DIR}"
echo ""
echo -e "${YELLOW}============================================${NC}"
echo ""
echo "请选择备份类型:"
echo ""
echo "  [1] 完整备份 (推荐) - 备份所有数据、结构、存储过程"
echo "  [2] 仅结构备份 - 只备份表结构，不含数据"
echo "  [3] 仅数据备份 - 只备份数据，不含结构"
echo "  [4] 自定义备份 - 选择特定表进行备份"
echo "  [5] 快速备份 - 使用默认设置直接备份"
echo ""
read -p "请输入选项 (1-5): " CHOICE

if [ "$CHOICE" = "5" ]; then
    exec "${BASH_SOURCE[0]%/*}/backup-database.sh"
fi

# 检查命令
if ! command -v mysqldump &> /dev/null; then
    echo -e "${RED}错误: 未找到 mysqldump 命令${NC}"
    exit 1
fi

# 创建备份目录
mkdir -p "${BACKUP_DIR}"

# 生成文件名
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

case $CHOICE in
    1)
        # 完整备份
        echo ""
        echo "执行完整备份..."
        BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_full_${TIMESTAMP}.sql"
        mysqldump --host="${DB_HOST}" --port="${DB_PORT}" \
                  --user="${DB_USER}" --password="${DB_PASS}" \
                  --single-transaction --routines --triggers --events \
                  "${DB_NAME}" > "${BACKUP_FILE}" 2>&1

        if [ $? -eq 0 ]; then
            success_backup "${BACKUP_FILE}"
        else
            error_backup
        fi
        ;;

    2)
        # 仅结构备份
        echo ""
        echo "执行结构备份..."
        BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_schema_${TIMESTAMP}.sql"
        mysqldump --host="${DB_HOST}" --port="${DB_PORT}" \
                  --user="${DB_USER}" --password="${DB_PASS}" \
                  --no-data "${DB_NAME}" > "${BACKUP_FILE}" 2>&1

        if [ $? -eq 0 ]; then
            success_backup "${BACKUP_FILE}"
        else
            error_backup
        fi
        ;;

    3)
        # 仅数据备份
        echo ""
        echo "执行数据备份..."
        BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_data_${TIMESTAMP}.sql"
        mysqldump --host="${DB_HOST}" --port="${DB_PORT}" \
                  --user="${DB_USER}" --password="${DB_PASS}" \
                  --no-create-info "${DB_NAME}" > "${BACKUP_FILE}" 2>&1

        if [ $? -eq 0 ]; then
            success_backup "${BACKUP_FILE}"
        else
            error_backup
        fi
        ;;

    4)
        # 自定义备份
        echo ""
        echo "获取数据库表列表..."
        TABLES=$(mysql --host="${DB_HOST}" --port="${DB_PORT}" \
                       --user="${DB_USER}" --password="${DB_PASS}" \
                       --skip-column-names "${DB_NAME}" -e "SHOW TABLES" 2>&1)

        if [ $? -ne 0 ]; then
            echo -e "${RED}错误: 无法获取表列表${NC}"
            exit 1
        fi

        echo ""
        echo "数据库表列表:"
        COUNT=0
        for TABLE in $TABLES; do
            COUNT=$((COUNT + 1))
            echo "  [${COUNT}] ${TABLE}"
            eval "TABLE_${COUNT}='${TABLE}'"
        done

        echo ""
        read -p "请输入要备份的表编号 (多个用空格分隔，如: 1 3 5，输入 ALL 备份所有表): " TABLE_NUMS

        BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_custom_${TIMESTAMP}.sql"

        if [ "$TABLE_NUMS" = "ALL" ]; then
            mysqldump --host="${DB_HOST}" --port="${DB_PORT}" \
                      --user="${DB_USER}" --password="${DB_PASS}" \
                      --single-transaction "${DB_NAME}" > "${BACKUP_FILE}" 2>&1
        else
            TABLES_TO_BACKUP=""
            for NUM in $TABLE_NUMS; do
                TABLE_VAR="TABLE_${NUM}"
                TABLE_VALUE="${!TABLE_VAR}"
                if [ -n "$TABLE_VALUE" ]; then
                    TABLES_TO_BACKUP="${TABLES_TO_BACKUP} ${TABLE_VALUE}"
                fi
            done

            mysqldump --host="${DB_HOST}" --port="${DB_PORT}" \
                      --user="${DB_USER}" --password="${DB_PASS}" \
                      --single-transaction "${DB_NAME}" ${TABLES_TO_BACKUP} > "${BACKUP_FILE}" 2>&1
        fi

        if [ $? -eq 0 ]; then
            success_backup "${BACKUP_FILE}"
        else
            error_backup
        fi
        ;;

    *)
        echo -e "${RED}无效选项${NC}"
        exit 1
        ;;
esac

# 成功处理函数
success_backup() {
    local FILE=$1
    echo ""
    echo -e "${GREEN}============================================${NC}"
    echo -e "${GREEN} 备份成功！${NC}"
    echo -e "${GREEN}============================================${NC}"
    echo ""
    echo "备份文件: ${FILE}"

    # 获取文件大小
    FILE_SIZE=$(du -h "${FILE}" | cut -f1)
    echo "文件大小: ${FILE_SIZE}"
    echo ""

    # 询问是否压缩
    read -p "是否压缩备份文件? (Y/n): " COMPRESS
    if [ "$COMPRESS" != "n" ] && [ "$COMPRESS" != "N" ]; then
        echo "正在压缩..."
        gzip "${FILE}"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}压缩成功: ${FILE}.gz${NC}"
        fi
    fi

    echo ""
    exit 0
}

# 错误处理函数
error_backup() {
    echo ""
    echo -e "${RED}============================================${NC}"
    echo -e "${RED} 备份失败！${NC}"
    echo -e "${RED}============================================${NC}"
    echo ""
    echo "请检查:"
    echo "  1. 数据库连接信息是否正确"
    echo "  2. 数据库服务是否运行"
    echo "  3. 用户是否有足够权限"
    echo ""
    exit 1
}
