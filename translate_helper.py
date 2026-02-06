#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
NexoPOS 中文翻译辅助脚本
使用方法: python translate_helper.py
"""

import json
import re

# 关键界面文本的中文翻译映射
translations = {
    # 通用
    "Save": "保存",
    "Cancel": "取消",
    "Submit": "提交",
    "Delete": "删除",
    "Edit": "编辑",
    "Create": "创建",
    "Search": "搜索",
    "Close": "关闭",
    "Apply": "应用",
    "Confirm": "确认",
    "Yes": "是",
    "No": "否",
    "OK": "确定",
    "Back": "返回",
    "Next": "下一步",
    "Previous": "上一步",
    "Continue": "继续",
    "Finish": "完成",
    "Download": "下载",
    "Upload": "上传",
    "Print": "打印",
    "Export": "导出",
    "Import": "导入",
    "Refresh": "刷新",
    "Load": "加载",
    "Loading": "加载中",
    "Processing": "处理中",
    "Proceed": "继续",
    "Register": "注册",
    "Login": "登录",
    "Logout": "登出",

    # 日期时间
    "Today": "今天",
    "Date": "日期",
    "Time": "时间",
    "Valid From": "有效期从",
    "Valid Till": "有效期至",
    "Expiration Date": "过期日期",

    # POS系统
    "Order": "订单",
    "Orders": "订单",
    "Product": "产品",
    "Products": "产品",
    "Customer": "客户",
    "Customers": "客户",
    "Cashier": "收银员",
    "Payment": "支付",
    "Total": "总计",
    "Sub Total": "小计",
    "Tax": "税",
    "Discount": "折扣",
    "Quantity": "数量",
    "Unit Price": "单价",
    "Total Price": "总价",
    "Amount": "金额",
    "Due": "应付",
    "Change": "找零",
    "Paid": "已支付",
    "Unpaid": "未支付",
    "Partially Paid": "部分支付",
    "Pending": "待处理",
    "Completed": "已完成",
    "Cancelled": "已取消",
    "Hold": "暂存",

    # 商品相关
    "SKU": "商品编号",
    "Barcode": "条形码",
    "Unit": "单位",
    "Price": "价格",
    "Cost": "成本",
    "Stock": "库存",
    "Categories": "分类",
    "Category": "分类",

    # 收银
    "Delivery": "配送",
    "Take Away": "外卖",
    "Shipping": "运费",
    "Billing Details": "账单详情",
    "Shipping Details": "配送详情",
    "Order Code": "订单号",
    "Payment Status": "支付状态",
    "Delivery Status": "配送状态",

    # 优惠券
    "Coupons": "优惠券",
    "Coupon": "优惠券",
    "Coupon Code": "优惠码",
    "Coupon Name": "优惠券名称",
    "Load Coupon": "加载优惠券",
    "Apply A Coupon": "使用优惠券",
    "Active Coupons": "可用优惠券",

    # 报表/统计
    "Total Sales": "总销售额",
    "Net Income": "净收入",
    "Expenses": "支出",
    "Best Cashiers": "最佳收银员",
    "Best Customers": "最佳客户",
    "Weekly Sales": "周销售额",
    "Incomplete Orders": "未完成订单",

    # 用户/权限
    "Username": "用户名",
    "Password": "密码",
    "Email": "邮箱",
    "Phone": "电话",
    "Address": "地址",
    "Role": "角色",
    "Permissions": "权限",

    # 错误消息
    "An unexpected error occurred": "发生意外错误",
    "Unable to proceed": "无法继续",
    "The form is not valid": "表单无效",
    "Please correct the errors": "请修正错误",
    "Required field": "必填字段",
    "Invalid value": "无效值",

    # 成功消息
    "Success": "成功",
    "Saved successfully": "保存成功",
    "Deleted successfully": "删除成功",
    "Updated successfully": "更新成功",
    "Created successfully": "创建成功",

    # 其他
    "Settings": "设置",
    "Dashboard": "仪表板",
    "Reports": "报表",
    "More Details": "更多详情",
    "Description": "描述",
    "Name": "名称",
    "Type": "类型",
    "Status": "状态",
    "Actions": "操作",
    "Value": "值",
    "Usage": "使用情况",
    "Unlimited": "无限制",
    "Store Details": "商店详情",
    "Percentage": "百分比",
    "Flat": "固定",
}

def translate_json():
    """翻译 JSON 文件"""
    try:
        # 读取英文文件
        print("正在读取英文语言文件...")
        with open('lang/en.json', 'r', encoding='utf-8') as f:
            en_data = json.load(f)

        print(f"共找到 {len(en_data)} 个条目")

        # 创建中文译文
        zh_data = {}
        translated_count = 0

        print("正在翻译...")
        for key, value in en_data.items():
            if key in translations:
                zh_data[key] = translations[key]
                translated_count += 1
            else:
                # 未翻译的保持英文
                zh_data[key] = value

        # 保存中文文件
        print(f"正在保存中文文件... (已翻译 {translated_count} 个常用词)")
        with open('lang/zh-CN.json', 'w', encoding='utf-8') as f:
            json.dump(zh_data, f, ensure_ascii=False, indent=2)

        print(f"✅ 完成！已翻译 {translated_count}/{len(en_data)} 个条目")
        print(f"翻译覆盖率: {(translated_count/len(en_data)*100):.2f}%")
        print("\n提示：您可以继续编辑 lang/zh-CN.json 文件添加更多翻译")

    except Exception as e:
        print(f"❌ 错误: {e}")

if __name__ == "__main__":
    translate_json()
