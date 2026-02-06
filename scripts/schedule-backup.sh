#!/bin/bash
# ============================================================
# NexoPOS 计划任务设置脚本 (Linux/macOS)
# 功能：设置每周一自动执行数据库备份
# 使用：sudo ./schedule-backup.sh
# ============================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}   NexoPOS 计划任务设置工具${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo "此脚本将创建一个 cron 定时任务"
echo "用于每周一凌晨 2:00 自动备份数据库"
echo ""
echo -e "${YELLOW}============================================${NC}"
echo ""

# 检查 root 权限
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}错误: 此脚本需要 root 权限${NC}"
    echo "请使用: sudo $0"
    exit 1
fi

# ============================================================
# 配置区域
# ============================================================

SCRIPT_DIR="/var/www/nexopos/scripts"
BACKUP_SCRIPT="${SCRIPT_DIR}/backup-database.sh"
LOG_FILE="/var/log/nexopos-backup.log"

# 检查备份脚本是否存在
if [ ! -f "$BACKUP_SCRIPT" ]; then
    # 尝试相对路径
    BACKUP_SCRIPT="$(dirname "$0")/backup-database.sh"
    if [ ! -f "$BACKUP_SCRIPT" ]; then
        echo -e "${RED}错误: 未找到备份脚本${NC}"
        echo "路径: ${BACKUP_SCRIPT}"
        exit 1
    fi
    SCRIPT_DIR="$(dirname "$BACKUP_SCRIPT")"
fi

# 确保脚本可执行
chmod +x "$BACKUP_SCRIPT"

# ============================================================
# 询问配置
# ============================================================

echo "默认配置:"
echo "  执行时间: 每周一 凌晨 2:00"
echo "  脚本路径: ${BACKUP_SCRIPT}"
echo ""

read -p "是否自定义执行时间? (y/N): " CUSTOM_TIME

if [ "$CUSTOM_TIME" = "y" ] || [ "$CUSTOM_TIME" = "Y" ]; then
    echo ""
    echo "时间格式: HH:MM (24小时制)"
    echo "示例: 02:00 (凌晨2点), 14:30 (下午2点半)"
    echo ""
    read -p "小时 (0-23): " HOUR
    read -p "分钟 (0-59): " MINUTE
    SCHEDULE_TIME="${HOUR}:${MINUTE}"

    # 验证时间格式
    if ! [[ "$HOUR" =~ ^[0-9]+$ ]] || ! [[ "$MINUTE" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}错误: 时间格式无效${NC}"
        exit 1
    fi

    if [ "$HOUR" -lt 0 ] || [ "$HOUR" -gt 23 ] || [ "$MINUTE" -lt 0 ] || [ "$MINUTE" -gt 59 ]; then
        echo -e "${RED}错误: 时间超出范围${NC}"
        exit 1
    fi
else
    SCHEDULE_TIME="02:00"
fi

echo ""
read -p "是否自定义执行日期? (y/N): " CUSTOM_DAY

if [ "$CUSTOM_DAY" = "y" ] || [ "$CUSTOM_DAY" = "Y" ]; then
    echo ""
    echo "选择星期:"
    echo "  [1] 星期一  [2] 星期二  [3] 星期三"
    echo "  [4] 星期四  [5] 星期五  [6] 星期六"
    echo "  [7] 星期日  [8] 每天"
    echo ""
    read -p "请输入选项 (1-8): " DAY_OPTION

    case $DAY_OPTION in
        1) SCHEDULE_DAY="1" ;;    # 星期一
        2) SCHEDULE_DAY="2" ;;    # 星期二
        3) SCHEDULE_DAY="3" ;;    # 星期三
        4) SCHEDULE_DAY="4" ;;    # 星期四
        5) SCHEDULE_DAY="5" ;;    # 星期五
        6) SCHEDULE_DAY="6" ;;    # 星期六
        7) SCHEDULE_DAY="0" ;;    # 星期日
        8) SCHEDULE_DAY="*" ;;    # 每天
        *)
            echo -e "${YELLOW}无效选项，使用默认值 (星期一)${NC}"
            SCHEDULE_DAY="1"
            ;;
    esac
else
    SCHEDULE_DAY="1"  # 星期一
fi

# ============================================================
# 生成 cron 表达式
# ============================================================

# 提取小时和分钟
CRON_MINUTE=$(echo "$SCHEDULE_TIME" | cut -d: -f1)
CRON_HOUR=$(echo "$SCHEDULE_TIME" | cut -d: -f2)

# Cron 格式: 分 时 日 月 周
CRON_EXPRESSION="${CRON_MINUTE} ${CRON_HOUR} * * ${SCHEDULE_DAY}"

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE} 计划任务配置确认${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo "Cron 表达式: ${CRON_EXPRESSION}"
echo "执行计划: 每周 星期${SCHEDULE_DAY} ${SCHEDULE_TIME}"
echo "执行脚本: ${BACKUP_SCRIPT}"
echo ""
read -p "确认创建? (y/N): " CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "操作已取消"
    exit 0
fi

# ============================================================
# 删除旧任务 (如果存在)
# ============================================================

echo ""
echo "正在检查旧任务..."
OLD_CRON=$(crontab -l 2>/dev/null | grep -v "NexoPOS_Weekly_Backup" | grep -v "$BACKUP_SCRIPT")

if [ -n "$OLD_CRON" ]; then
    # 备份旧 crontab
    crontab -l > /tmp/crontab.backup.$$ 2>/dev/null
    echo "已备份现有 crontab 到 /tmp/crontab.backup.$$"
fi

# ============================================================
# 创建新任务
# ============================================================

echo "正在创建计划任务..."

# 添加新的 cron 任务
(crontab -l 2>/dev/null | grep -v "NexoPOS_Weekly_Backup"; echo "# NexoPOS_Weekly_Backup - 每周一自动备份 (${CRON_EXPRESSION})") | crontab -
(crontab -l 2>/dev/null | grep -v "NexoPOS_Weekly_Backup"; echo "${CRON_EXPRESSION} ${BACKUP_SCRIPT} >> ${LOG_FILE} 2>&1") | crontab -

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}============================================${NC}"
    echo -e "${GREEN} 计划任务创建成功！${NC}"
    echo -e "${GREEN}============================================${NC}"
    echo ""
    echo "Cron 表达式: ${CRON_EXPRESSION}"
    echo "执行计划: 每周 星期${SCHEDULE_DAY} ${SCHEDULE_TIME}"
    echo ""
    echo "常用命令:"
    echo "  查看当前任务: crontab -l"
    echo "  编辑任务: crontab -e"
    echo "  删除任务: crontab -e (删除相关行)"
    echo "  查看日志: tail -f ${LOG_FILE}"
    echo ""
    echo "提示: 查看下次执行时间"
    echo "  使用工具: https://crontab.guru/"
    echo ""
else
    echo ""
    echo -e "${RED}============================================${NC}"
    echo -e "${RED} 计划任务创建失败！${NC}"
    echo -e "${RED}============================================${NC}"
    echo ""
    exit 1
fi

exit 0
