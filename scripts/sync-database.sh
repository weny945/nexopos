#!/bin/bash
# ============================================================
# NexoPOS 数据库同步脚本 (Linux/macOS)
# 功能：将源数据库同步到目标数据库
# 用途：开发环境 <-> 生产环境 数据同步
# ============================================================

# ============================================================
# 配置区域 - 根据实际情况修改
# ============================================================

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

# 备份目录
BACKUP_DIR="/var/www/nexopos/database/sync-backups"
LOG_FILE="${BACKUP_DIR}/sync.log"

# 同步选项
BACKUP_BEFORE_SYNC="YES"          # 同步前是否备份目标数据库
DROP_TABLES_FIRST="YES"           # 是否先删除目标数据库的表
SKIP_TABLES=""                    # 跳过的表 (逗号分隔): table1,table2
ONLY_TABLES=""                    # 只同步特定表 (逗号分隔): table1,table2
USE_TEMP_FILE="YES"               # 是否使用临时文件 (大数据库建议设为 YES)

# ============================================================
# 初始化
# ============================================================

# 创建备份目录
mkdir -p "${BACKUP_DIR}"

# 日志开始
{
    echo "================================"
    echo "同步开始时间: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "源数据库: ${SOURCE_DB} (${SOURCE_HOST})"
    echo "目标数据库: ${TARGET_DB} (${TARGET_HOST})"
    echo ""
} >> "${LOG_FILE}"

# 时间戳
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# 检查命令是否可用
if ! command -v mysqldump &> /dev/null || ! command -v mysql &> /dev/null; then
    echo "错误: 未找到 MySQL 客户端工具" >> "${LOG_FILE}"
    exit 1
fi

# ============================================================
# 确认同步操作
# ============================================================
echo "警告: 此操作将覆盖目标数据库 [${TARGET_DB}] 的所有数据！"
echo "源数据库: ${SOURCE_DB}"
echo "目标数据库: ${TARGET_DB}"
echo ""
read -p "确认继续同步? (输入 YES 继续): " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    echo "同步已取消" >> "${LOG_FILE}"
    exit 0
fi

echo "" >> "${LOG_FILE}"

# ============================================================
# 步骤 1: 备份目标数据库
# ============================================================
if [ "$BACKUP_BEFORE_SYNC" = "YES" ]; then
    echo "[步骤 1/4] 正在备份目标数据库..." >> "${LOG_FILE}"
    PRE_BACKUP="${BACKUP_DIR}/${TARGET_DB}_before_sync_${TIMESTAMP}.sql"

    mysqldump --host="${SOURCE_HOST}" \
              --port="${SOURCE_PORT}" \
              --user="${SOURCE_USER}" \
              --password="${SOURCE_PASS}" \
              --single-transaction \
              --routines \
              --triggers \
              --events \
              "${TARGET_DB}" > "${PRE_BACKUP}" 2>> "${LOG_FILE}"

    if [ $? -eq 0 ]; then
        echo "  备份成功: ${PRE_BACKUP}" >> "${LOG_FILE}"

        # 压缩备份
        gzip "${PRE_BACKUP}"
        echo "  备份已压缩: ${PRE_BACKUP}.gz" >> "${LOG_FILE}"
    else
        echo "  错误: 备份失败" >> "${LOG_FILE}"
        exit 1
    fi
    echo "" >> "${LOG_FILE}"
fi

# ============================================================
# 步骤 2: 删除目标数据库的现有表
# ============================================================
if [ "$DROP_TABLES_FIRST" = "YES" ]; then
    echo "[步骤 2/4] 正在删除目标数据库的表..." >> "${LOG_FILE}"

    # 获取所有表名并逐个删除
    TABLES=$(mysql --host="${TARGET_HOST}" \
                   --port="${TARGET_PORT}" \
                   --user="${TARGET_USER}" \
                   --password="${TARGET_PASS}" \
                   --skip-column-names \
                   "${TARGET_DB}" -e "SHOW TABLES" 2>> "${LOG_FILE}")

    if [ $? -eq 0 ]; then
        for TABLE in $TABLES; do
            if [ -n "$TABLE" ]; then
                echo "  DROP TABLE ${TABLE}" >> "${LOG_FILE}"
                mysql --host="${TARGET_HOST}" \
                     --port="${TARGET_PORT}" \
                     --user="${TARGET_USER}" \
                     --password="${TARGET_PASS}" \
                     "${TARGET_DB}" -e "SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS ${TABLE}; SET FOREIGN_KEY_CHECKS=1;" 2>> "${LOG_FILE}"
            fi
        done
        echo "  删除完成" >> "${LOG_FILE}"
    else
        echo "  警告: 获取表列表失败" >> "${LOG_FILE}"
    fi
    echo "" >> "${LOG_FILE}"
fi

# ============================================================
# 步骤 3: 从源数据库导出并导入到目标数据库
# ============================================================
echo "[步骤 3/4] 正在同步数据..." >> "${LOG_FILE}"

# 构建 mysqldump 参数
DUMP_CMD="mysqldump --host=${SOURCE_HOST} --port=${SOURCE_PORT} --user=${SOURCE_USER} --password=${SOURCE_PASS} --single-transaction --routines --triggers --events"

# 添加排除表参数
if [ -n "$SKIP_TABLES" ]; then
    IFS=',' read -ra TABLES <<< "$SKIP_TABLES"
    for TABLE in "${TABLES[@]}"; do
        DUMP_CMD="${DUMP_CMD} --ignore-table=${SOURCE_DB}.${TABLE}"
    done
    echo "  跳过表: ${SKIP_TABLES}" >> "${LOG_FILE}"
fi

# 添加特定表参数
if [ -n "$ONLY_TABLES" ]; then
    DUMP_CMD="${DUMP_CMD} ${SOURCE_DB} ${ONLY_TABLES}"
    echo "  只同步表: ${ONLY_TABLES}" >> "${LOG_FILE}"
else
    DUMP_CMD="${DUMP_CMD} ${SOURCE_DB}"
fi

# 执行导出导入
if [ "$USE_TEMP_FILE" = "YES" ]; then
    # 使用临时文件方式 (适合大数据库)
    TEMP_SQL="${BACKUP_DIR}/temp_export_${TIMESTAMP}.sql"
    echo "  导出源数据库..." >> "${LOG_FILE}"
    $DUMP_CMD 2>> "${LOG_FILE}" > "${TEMP_SQL}"

    if [ $? -eq 0 ]; then
        echo "  导入到目标数据库..." >> "${LOG_FILE}"
        mysql --host="${TARGET_HOST}" \
              --port="${TARGET_PORT}" \
              --user="${TARGET_USER}" \
              --password="${TARGET_PASS}" \
              "${TARGET_DB}" < "${TEMP_SQL}" 2>> "${LOG_FILE}"
        IMPORT_RESULT=$?
        rm -f "${TEMP_SQL}"
    else
        IMPORT_RESULT=1
    fi
else
    # 直接管道传输 (节省磁盘空间)
    echo "  直接管道传输..." >> "${LOG_FILE}"
    $DUMP_CMD 2>> "${LOG_FILE}" | mysql --host="${TARGET_HOST}" \
                                         --port="${TARGET_PORT}" \
                                         --user="${TARGET_USER}" \
                                         --password="${TARGET_PASS}" \
                                         "${TARGET_DB}" 2>> "${LOG_FILE}"
    IMPORT_RESULT=$?
fi

if [ $IMPORT_RESULT -eq 0 ]; then
    echo "  同步成功" >> "${LOG_FILE}"
else
    echo "  错误: 同步失败" >> "${LOG_FILE}"
    exit 1
fi

echo "" >> "${LOG_FILE}"

# ============================================================
# 步骤 4: 验证同步结果
# ============================================================
echo "[步骤 4/4] 正在验证同步结果..." >> "${LOG_FILE}"

# 统计源数据库表数量
SOURCE_TABLES=$(mysql --host="${SOURCE_HOST}" \
                      --port="${SOURCE_PORT}" \
                      --user="${SOURCE_USER}" \
                      --password="${SOURCE_PASS}" \
                      --skip-column-names \
                      "${SOURCE_DB}" -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${SOURCE_DB}'" 2>> "${LOG_FILE}")

# 统计目标数据库表数量
TARGET_TABLES=$(mysql --host="${TARGET_HOST}" \
                      --port="${TARGET_PORT}" \
                      --user="${TARGET_USER}" \
                      --password="${TARGET_PASS}" \
                      --skip-column-names \
                      "${TARGET_DB}" -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${TARGET_DB}'" 2>> "${LOG_FILE}")

echo "  源数据库表数量: ${SOURCE_TABLES}" >> "${LOG_FILE}"
echo "  目标数据库表数量: ${TARGET_TABLES}" >> "${LOG_FILE}"

if [ "${SOURCE_TABLES}" = "${TARGET_TABLES}" ]; then
    echo "  验证通过" >> "${LOG_FILE}"
else
    echo "  警告: 表数量不匹配" >> "${LOG_FILE}"
fi

# ============================================================
# 完成
# ============================================================
{
    echo ""
    echo "同步完成时间: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "================================"
    echo ""
} >> "${LOG_FILE}"

echo "数据库同步完成！"
echo "查看日志: ${LOG_FILE}"

exit 0
