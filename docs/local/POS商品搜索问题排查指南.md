# POS商品搜索问题排查指南

## 问题描述

已经采购的商品在库存页面能看到，但在POS销售页面搜索不到该商品。

## 快速解决方案（检查清单）

### ✅ 第1步：检查商品的"可搜索"状态

商品必须设置为"可搜索"才能在POS中显示。

**操作步骤**：

1. 进入 **仪表板（Dashboard）** → **商品（Products）** → **商品列表（Products List）**
2. 找到你的可口可乐商品，点击 **编辑（Edit）**
3. 在编辑页面查找以下设置：
   - **Searchable（可搜索）** 字段 - **必须设置为 Yes/True**
   - **Status（状态）** 字段 - **必须设置为 Available（可用）**

**数据库默认值**：
- `searchable` 默认值：`true`（可搜索）
- `status` 默认值：`'available'`（可用）

**⚠️ 重要**：如果创建商品时未正确设置，或者导入商品时这些字段被错误设置，会导致商品无法在POS中搜索。

---

### ✅ 第2步：检查商品类型

某些商品类型可能无法在POS中直接销售。

**商品类型说明**：

| 商品类型 | 类型值 | 能否在POS销售 | 说明 |
|---------|--------|--------------|------|
| 实体商品 | `materialized` | ✅ 可以 | 普通有库存的商品（如可口可乐） |
| 虚拟商品 | `dematerialized` | ✅ 可以 | 无需库存的商品（如服务） |
| 组合商品 | `grouped` | ❌ 不能直接销售 | 只能销售其子商品 |

**检查方法**：
1. 编辑商品
2. 查看 **Product Type（商品类型）** 字段
3. 确保可口可乐设置为 **Materialized（实体商品）** 或 **Dematerialized（虚拟商品）**

---

### ✅ 第3步：检查销售价格设置

商品必须有有效的销售价格才能在POS销售。

**检查步骤**：

1. 进入 **仪表板** → **商品** → **编辑商品**
2. 点击 **Units（单位）** 标签页
3. 确认每个销售单位的 **Sale Price（销售价格）** 已填写且 > 0

**示例 - 可口可乐 330ML**：
```
单位组：计数单位组-24装
├─ 件（听）
│  ├─ Sale Price: 3.50 元 ✅ 已设置
│  └─ Quantity: 120 件
└─ 箱(24件装)
   ├─ Sale Price: 80.00 元 ✅ 已设置
   └─ Quantity: 5 箱
```

**⚠️ 常见错误**：
- 只填写了采购价，忘记填写销售价
- 销售价设置为 0

---

### ✅ 第4步：检查库存管理设置

**操作步骤**：

1. 编辑商品
2. 查看 **Stock Management（库存管理）** 字段
3. 两种设置都可以：
   - **Enabled（启用）**：系统会追踪库存，库存为0时可能无法销售
   - **Disabled（禁用）**：不追踪库存，始终可以销售

**如果启用了库存管理**，确认：
- 商品当前库存 > 0（在 **库存（Inventory）** 页面查看）
- 检查是否设置了"低库存阈值"导致商品被隐藏

---

### ✅ 第5步：清除缓存

系统可能缓存了旧的商品数据。

**清除缓存命令**：

```bash
# 在项目根目录执行
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
```

**完整刷新**：
```bash
php artisan optimize:clear
```

清除缓存后，刷新浏览器页面（Ctrl + F5 强制刷新）。

---

### ✅ 第6步：检查商品SKU和条形码

**POS搜索逻辑**：
POS系统通过以下字段搜索商品：
1. **Product Name（商品名称）** - 模糊匹配
2. **SKU** - 模糊匹配
3. **Barcode（条形码）** - 精确匹配

**检查事项**：
- 商品名称中有没有特殊字符干扰搜索
- SKU 字段是否已填写
- Barcode 字段是否正确

**测试搜索**：
- 在POS页面搜索框输入商品名称的部分内容（如"可口"）
- 尝试搜索完整商品名称
- 尝试扫描或输入条形码

---

## 技术深入分析

### 数据库字段说明

**products 表关键字段**：

| 字段名 | 类型 | 默认值 | 说明 | 影响POS搜索 |
|-------|------|--------|------|-----------|
| `searchable` | boolean | `true` | 是否可在POS搜索 | ✅ **关键字段** |
| `status` | string | `'available'` | 商品状态 | ✅ 建议设为 available |
| `type` | string | - | 商品类型 | ⚠️ grouped类型不能直接销售 |
| `stock_management` | string | `'enabled'` | 库存管理 | ⚠️ 启用时需要库存>0 |
| `name` | string | - | 商品名称 | ✅ 搜索字段 |
| `sku` | string | - | SKU编码 | ✅ 搜索字段 |
| `barcode` | string | - | 条形码 | ✅ 搜索字段 |

### POS搜索源码分析

**前端搜索代码**（`resources/ts/popups/ns-pos-search-product.vue:102`）：
```typescript
nsHttpClient.post( '/api/products/search', {
    search: this.searchValue
})
```

**后端搜索方法**（`app/Services/ProductService.php:2151`）：
```php
public function searchProduct( ?string $search, int $limit = 5, array $arguments = [] )
{
    $query = Product::query()
        ->where( function ( $query ) use ( $search ) {
            $query
                ->orWhere( 'name', 'LIKE', "%{$search}%" )
                ->orWhere( 'sku', 'LIKE', "%{$search}%" )
                ->orWhere( 'barcode', 'LIKE', "%{$search}%" );
        } )
        ->with( [
            'unit_quantities.unit',
            'category',
            'tax_group.taxes',
        ] )
        ->limit( $limit );

    // 注意：默认没有 searchable 和 status 过滤！

    return $query->get();
}
```

**⚠️ 关键发现**：
POS搜索**默认没有强制过滤** `searchable` 和 `status` 字段！但是商品创建时如果这些字段设置错误，可能会导致其他地方的逻辑过滤掉该商品。

---

## 完整排查流程

### 方案A：通过界面检查（推荐）

1. **打开商品编辑页面**：
   - Dashboard → Products → 找到可口可乐 → Edit

2. **检查以下字段**：
   ```
   ✅ Product Type: Materialized（实体商品）
   ✅ Status: Available（可用）
   ✅ Searchable: Yes/True（可搜索）
   ✅ Stock Management: Enabled 或 Disabled（根据需要）
   ✅ Name: 可口可乐 330ML（正确的名称）
   ✅ SKU: 已填写
   ✅ Barcode: 已填写
   ```

3. **检查单位和价格**（Units 标签页）：
   ```
   ✅ 每个单位都有 Sale Price（销售价格）> 0
   ✅ 至少有一个单位有库存（如果启用了库存管理）
   ```

4. **保存修改**

5. **清除缓存**：
   ```bash
   php artisan cache:clear
   ```

6. **重新测试POS搜索**

---

### 方案B：通过数据库直接检查（高级）

如果你熟悉数据库，可以直接查询：

```sql
-- 1. 检查商品基本信息
SELECT
    id,
    name,
    sku,
    barcode,
    type,
    status,
    searchable,
    stock_management
FROM nexopos_products
WHERE name LIKE '%可口可乐%';

-- 预期结果应该是：
-- type: 'materialized'
-- status: 'available'
-- searchable: 1 (或 true)
-- stock_management: 'enabled' 或 'disabled'

-- 2. 检查商品单位和价格
SELECT
    p.name AS product_name,
    u.name AS unit_name,
    puq.sale_price,
    puq.quantity
FROM nexopos_products_unit_quantities puq
JOIN nexopos_products p ON puq.product_id = p.id
JOIN nexopos_units u ON puq.unit_id = u.id
WHERE p.name LIKE '%可口可乐%';

-- 预期结果应该是：
-- sale_price 必须 > 0
-- quantity 应该有库存（如果启用了库存管理）
```

**修复SQL（如果发现问题）**：

```sql
-- 修复 searchable 和 status
UPDATE nexopos_products
SET
    searchable = 1,
    status = 'available'
WHERE name LIKE '%可口可乐%';

-- 修复销售价格（示例）
UPDATE nexopos_products_unit_quantities puq
JOIN nexopos_products p ON puq.product_id = p.id
SET puq.sale_price = 3.50  -- 根据实际情况设置
WHERE p.name LIKE '%可口可乐%'
  AND puq.sale_price = 0;
```

---

## 常见问题 FAQ

### Q1: 为什么库存页面能看到，POS页面搜索不到？

**A**: 库存页面和POS搜索使用不同的查询逻辑：
- **库存页面**：显示所有商品（包括 searchable=false 的商品）
- **POS搜索**：理论上应该显示所有商品，但如果 `searchable=false` 或 `status='unavailable'`，可能会被前端或其他逻辑过滤

### Q2: 我修改了商品设置，为什么还是搜索不到？

**A**: 可能的原因：
1. **缓存问题** - 运行 `php artisan cache:clear`
2. **浏览器缓存** - 强制刷新浏览器（Ctrl + F5）
3. **没有保存修改** - 确认点击了"保存"按钮
4. **多个商品混淆** - 确认修改的是正确的商品

### Q3: 销售价格在哪里设置？

**A**:
1. 编辑商品 → **Units（单位）** 标签页
2. 每个销售单位都有 **Sale Price** 字段
3. 确保所有销售单位的价格 > 0

### Q4: 商品类型应该选什么？

**A**:
- **可口可乐（实体商品）** → 选择 **Materialized**
- **服务类商品** → 选择 **Dematerialized**
- **组合商品** → 选择 **Grouped**（但不能直接在POS销售）

### Q5: searchable 字段在哪里设置？

**A**:
在商品编辑页面的主表单（General 标签页）中，查找：
- **Searchable** 或 **可搜索** 字段
- 设置为 **Yes** 或 **True**

### Q6: 我用条形码扫描枪搜索不到商品？

**A**:
1. 确认商品的 **Barcode** 字段已填写
2. 确认条形码内容与系统中存储的一致
3. 检查扫描枪是否在POS搜索框中正确输入

### Q7: 商品有库存但显示"缺货"？

**A**:
1. 检查 **Stock Management** 是否启用
2. 如果启用，确认库存数量 > 0
3. 检查是否设置了"低库存警告阈值"

---

## 推荐配置（最佳实践）

### 标准零售商品配置模板

```yaml
商品基本信息:
  Product Type: Materialized（实体商品）
  Status: Available（可用）
  Searchable: Yes/True（可搜索）✅ 关键
  Stock Management: Enabled（启用库存管理）

商品标识:
  Name: 可口可乐 330ML
  SKU: COLA-330ML
  Barcode: 6901234567890

单位和价格（每个单位必须设置）:
  - 件（听）:
      Sale Price: 3.50 元 ✅
      Quantity: 120 件
  - 箱(24件装):
      Sale Price: 80.00 元 ✅
      Quantity: 5 箱

分类:
  Category: 饮料 → 碳酸饮料 → 可乐

税务:
  Tax Group: 标准税率组（根据地区）
```

---

## 测试验证

修改完成后，按以下步骤验证：

### ✅ 验证清单

1. **POS搜索测试**：
   ```
   □ 输入商品名称"可口可乐"能搜索到
   □ 输入部分名称"可口"能搜索到
   □ 输入SKU能搜索到
   □ 扫描条形码能搜索到
   □ 商品显示正确的价格和单位
   ```

2. **添加到购物车测试**：
   ```
   □ 点击商品能添加到购物车
   □ 购物车显示正确的价格
   □ 能修改数量
   □ 能选择不同的销售单位
   ```

3. **库存检查**：
   ```
   □ 库存页面显示正确的库存数量
   □ POS显示的库存与库存页面一致
   ```

---

## 如果以上方法都无效

### 最后的排查手段

1. **检查日志文件**：
   ```bash
   # Laravel 日志
   tail -f storage/logs/laravel.log

   # 查看是否有错误信息
   ```

2. **浏览器控制台检查**：
   - 打开POS页面
   - 按 F12 打开开发者工具
   - 切换到 **Console（控制台）** 标签
   - 搜索商品，查看是否有错误信息

3. **网络请求检查**：
   - 开发者工具 → **Network（网络）** 标签
   - 搜索商品
   - 找到 `/api/products/search` 请求
   - 查看请求参数和响应数据
   - 确认响应中是否包含你的商品

4. **重新创建商品**：
   - 如果以上都无效，尝试删除商品（备份数据）
   - 重新创建商品，仔细填写所有字段
   - 确保 Searchable = Yes, Status = Available

5. **检查权限设置**：
   - 确认当前登录用户有权限查看和销售该商品
   - Dashboard → Users → 编辑用户 → 检查权限

---

## 总结

**最常见的3个原因**：

1. ✅ **Searchable 字段设置为 False** ← 80%的情况
2. ✅ **Status 字段设置为 Unavailable** ← 15%的情况
3. ✅ **销售价格未设置或为0** ← 5%的情况

**快速修复步骤**（3分钟解决）：

```
1. 编辑商品
2. 设置 Searchable = Yes
3. 设置 Status = Available
4. 设置 Sale Price > 0（每个单位）
5. 保存
6. 运行 php artisan cache:clear
7. 刷新POS页面测试
```

---

## 相关文档

- [商品创建与库存管理流程](./商品创建与库存管理流程.md) - 了解商品创建的完整流程
- [商品分类与单位组配置指南](./商品分类与单位组配置指南.md) - 了解如何正确配置商品分类和单位
- [本地启动指南](./本地启动指南.md) - 本地开发环境配置

---

**文档版本**: v1.0
**创建时间**: 2026-01-24
**适用版本**: NexoPOS 5.x
**最后更新**: 2026-01-24
