<?php

/**
 * 商品数据调试脚本
 * 检查商品的单位数量配置是否完整
 */

require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\Product;
use App\Models\ProductUnitQuantity;

echo "=== 商品数据检查 ===\n\n";

// 获取所有可口可乐商品
$products = Product::where('name', 'LIKE', '%可口可乐%')
    ->with(['unit_quantities.unit', 'unitGroup.units'])
    ->get();

if ($products->isEmpty()) {
    echo "❌ 未找到可口可乐商品\n";
    echo "请检查商品名称是否包含'可口可乐'\n";
    exit;
}

foreach ($products as $product) {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
    echo "商品ID: {$product->id}\n";
    echo "商品名称: {$product->name}\n";
    echo "SKU: {$product->sku}\n";
    echo "条形码: {$product->barcode}\n";
    echo "商品类型: {$product->type}\n";
    echo "状态: {$product->status}\n";
    echo "可搜索: " . ($product->searchable ? 'Yes' : 'No') . "\n";
    echo "库存管理: {$product->stock_management}\n";
    echo "单位组ID: {$product->unit_group}\n";
    echo "\n";

    // 检查单位组
    if ($product->unitGroup) {
        echo "✅ 单位组: {$product->unitGroup->name}\n";
        echo "   单位组包含的单位:\n";
        foreach ($product->unitGroup->units as $unit) {
            echo "   - {$unit->name} (ID: {$unit->id}, 基础单位: " . ($unit->base_unit ? 'Yes' : 'No') . ")\n";
        }
    } else {
        echo "❌ 未关联单位组！\n";
    }
    echo "\n";

    // 检查单位数量配置
    echo "单位数量配置 (unit_quantities):\n";
    if ($product->unit_quantities->isEmpty()) {
        echo "❌ 警告：商品没有配置任何单位数量！这会导致POS无法销售。\n";
        echo "   请在商品编辑页面的 Units 标签页添加单位。\n";
    } else {
        foreach ($product->unit_quantities as $uq) {
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
            echo "  单位数量ID: {$uq->id}\n";

            if ($uq->unit) {
                echo "  ✅ 单位: {$uq->unit->name} (ID: {$uq->unit_id})\n";
            } else {
                echo "  ❌ 单位关系丢失！unit_id: {$uq->unit_id}\n";
            }

            echo "  条形码: " . ($uq->barcode ?? '未设置') . "\n";
            echo "  销售价格: {$uq->sale_price}\n";
            echo "  含税销售价: " . ($uq->sale_price_with_tax ?? '未计算') . "\n";
            echo "  不含税销售价: " . ($uq->sale_price_without_tax ?? '未计算') . "\n";
            echo "  批发价: {$uq->wholesale_price}\n";
            echo "  库存数量: {$uq->quantity}\n";
            echo "\n";

            // 检查问题
            $issues = [];

            if (!$uq->unit) {
                $issues[] = "单位关系丢失（unit_id={$uq->unit_id} 的单位不存在）";
            }

            if ($uq->sale_price <= 0) {
                $issues[] = "销售价格未设置或为0";
            }

            if (empty($uq->barcode)) {
                $issues[] = "条形码未设置（可选）";
            }

            if (!empty($issues)) {
                echo "  ⚠️  问题:\n";
                foreach ($issues as $issue) {
                    echo "     - {$issue}\n";
                }
            } else {
                echo "  ✅ 此单位配置正常\n";
            }
        }
    }

    echo "\n";
}

echo "\n=== 检查完成 ===\n\n";

echo "📋 诊断建议:\n\n";
echo "1. 如果显示 '❌ 商品没有配置任何单位数量':\n";
echo "   → 进入 Dashboard → Products → 编辑商品 → Units 标签页\n";
echo "   → 点击 'Add Unit' 添加销售单位\n";
echo "   → 设置销售价格和库存数量\n\n";

echo "2. 如果显示 '❌ 单位关系丢失':\n";
echo "   → 数据库关系不一致，unit_id 指向的单位不存在\n";
echo "   → 删除该单位数量记录并重新添加\n\n";

echo "3. 如果显示 '销售价格未设置或为0':\n";
echo "   → 编辑商品 → Units 标签页 → 设置 Sale Price > 0\n\n";

echo "4. 如果所有配置都正常但POS仍搜索不到:\n";
echo "   → 运行: php artisan cache:clear\n";
echo "   → 刷新浏览器页面 (Ctrl + F5)\n\n";
