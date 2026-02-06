# CLAUDE.md

此文件为 Claude Code (claude.ai/code) 在此代码库中工作时提供指导。

## 项目概述

NexoPOS 是一个现代化的免费点对点销售系统 (Point of Sale System)，使用 Laravel 12、Vue 3、TypeScript 和 TailwindCSS 构建。这是一个功能完整的企业级 POS 系统,支持库存管理、订单处理、客户关系管理、多语言和多货币。

**技术栈**:
- **后端**: Laravel 12.0 + PHP 8.2+
- **前端**: Vue 3.5 + TypeScript + Vite 7.1
- **样式**: TailwindCSS 4.1 + SCSS
- **数据库**: MySQL/SQLite + Eloquent ORM
- **实时通信**: Laravel Reverb (WebSocket) + Pusher
- **测试**: PHPUnit 11.5 (支持并行执行)

## 常用命令

### 开发环境设置

```bash
# 1. 安装依赖
composer install
npm install

# 2. 环境配置
cp .env.example .env
php artisan key:generate
php artisan storage:link

# 3. 初始化系统
php artisan ns:translate --symlink --force
php artisan modules:symlink

# 4. 数据库迁移
php artisan migrate
```

### 开发工作流

```bash
# 启动后端开发服务器 (终端 1)
php artisan serve

# 启动前端 Vite HMR 服务器 (终端 2)
npm run dev
# 或者
npx vite

# 启动队列处理器 (终端 3, 可选)
php artisan queue:work

# 启动 WebSocket 服务器 (终端 4, 可选)
php artisan reverb:start
```

### 构建和测试

```bash
# 前端构建
npm run build          # 生产构建
npm run watch          # 监视模式构建
npm test               # Jest 前端测试

# 后端测试
./vendor/bin/phpunit                    # 运行所有测试
./vendor/bin/phpunit --parallel         # 并行运行测试
./vendor/bin/phpunit --testsuite Sequential-1    # 运行特定测试套件
./vendor/bin/phpunit --filter CreateOrderTest   # 运行特定测试

# 代码风格检查和修复
./vendor/bin/pint                       # Laravel Pint 代码格式化
```

### NexoPOS 特定命令

```bash
# 模块管理
php artisan module:make <ModuleName>           # 创建新模块
php artisan module:delete <ModuleName>         # 删除模块
php artisan modules:symlink                    # 创建模块符号链接

# CRUD 生成
php artisan crud:make <CrudName>               # 生成 CRUD 资源

# 用户管理
php artisan create:user                        # 创建管理员用户

# 翻译
php artisan ns:translate --symlink --force     # 设置语言文件链接

# 数据库快照 (用于测试)
php artisan snapshot:create <name>             # 创建数据库快照
php artisan snapshot:load <name>               # 加载数据库快照
```

## 核心架构

### 后端分层架构

NexoPOS 使用**服务层模式**将业务逻辑与控制器分离:

```
HTTP Request
    ↓
Middleware (18+ 个中间件: 认证、权限、健康检查、安装状态等)
    ↓
Routes (路由层: api.php, web.php, 支持模块化路由)
    ↓
Controllers (控制器层: 主要使用 CrudController 处理 CRUD 操作)
    ↓
Services (服务层: 30+ 个服务, 核心业务逻辑在此)
    ↓
Models (模型层: 30+ Eloquent 模型)
    ↓
Database (数据库层: MySQL/SQLite)
```

**关键服务**:
- `CoreService`: 核心服务容器,依赖注入中心
- `CrudService`: 通用 CRUD 操作服务,支持反射和钩子扩展
- `OrdersService`: 订单处理、支付、退款核心逻辑
- `ProductService`: 产品管理、库存控制
- `CustomerService`: 客户管理、客户账户余额
- `CurrencyService`: 货币转换和格式化
- `DateService`: 日期时间处理 (单例模式)
- `MediaService`: 文件/图片上传和管理

**钩子系统** (基于 `tormjens/eventy`):
- 类似 WordPress 的过滤器和动作钩子
- 允许模块和扩展在不修改核心代码的情况下扩展功能
- 使用 `Hook::addFilter()` 和 `Hook::addAction()`

**CRUD 系统**:
- 自动生成表单、表格和验证
- 通过配置类 (`app/Crud/`) 定义 CRUD 行为
- 支持批量操作、关系映射、查询过滤

### 前端架构

**入口点** (在 `vite.config.js` 中定义):
- `bootstrap.ts`: 全局依赖初始化 (Axios, Lodash, Moment 等)
- `app.ts`: 主应用 (仪表板)
- `pos.ts`: POS 收银系统
- `auth.ts`: 认证页面
- `setup.ts`: 安装向导
- `cashier.ts`: 收银台

**状态管理**:
- 使用 RxJS Subject 模式管理全局状态
- 事件总线 (`EventEmitter`) 用于组件间通信
- HTTP 客户端封装 (`libraries/http-client.ts`) 基于 Axios + RxJS

**组件组织**:
- 全局组件在 `resources/ts/components/` 中注册
- 页面组件在 `resources/ts/pages/` (按功能模块分组)
- 可复用库在 `resources/ts/libraries/`

**路径别名** (在 TypeScript 和 Vite 中配置):
- `~` → `resources/ts/`
- `&` → `resources/`

### 模块系统

NexoPOS 支持模块化扩展:
- 模块位于 `modules/` 目录
- 使用 `php artisan module:make <Name>` 创建模块
- 模块有自己的路由、控制器、视图、迁移和资源
- 模块通过钩子系统与核心交互
- 使用 `modules:symlink` 创建模块资源链接

### 数据库结构

**迁移组织**:
- `database/migrations/core/`: 核心系统迁移
- `database/migrations/create/`: 创建表迁移
- `database/migrations/update/`: 更新表迁移

**关键模型** (30+ 个):
- `User`, `Role`, `Permission`: 用户和权限
- `Order`, `OrderPayment`, `OrderProduct`: 订单系统
- `Product`, `ProductCategory`, `ProductUnit`: 产品管理
- `Customer`, `CustomerGroup`, `CustomerAddress`: 客户管理
- `Procurement`, `ProcurementProduct`: 采购系统
- `Tax`, `TaxGroup`: 税务系统
- `Coupon`, `Reward`: 促销系统

**数据库前缀**: `ns_` (可在 `.env` 中通过 `DB_PREFIX` 配置)

## 测试架构

**测试套件组织** (PHPUnit):
1. **Sequential-1**: 基础顺序测试
   - 语言文件验证
   - 测试数据库创建
   - 硬重置测试

2. **Parallel-1**: 可并行的功能测试 (第一批)
   - CRUD 操作、字段、表单渲染
   - 认证、权限、设置保存
   - 模块上传

3. **Sequential-2**: 集成测试工作流 (必须顺序执行)
   - 税务 → 客户 → 单位 → 分类 → 产品 → 采购 → 优惠券 → 订单
   - 创建依赖对象 (税、客户组、单位组、产品等)

4. **Parallel-2**: 订单处理测试 (第二批)
   - 创建订单、退款、暂存订单、分期付款
   - 购物车操作、优惠券应用、报表生成

**运行特定测试**:
```bash
# 运行单个测试文件
./vendor/bin/phpunit tests/Feature/CreateOrderTest.php

# 运行特定测试套件
./vendor/bin/phpunit --testsuite Sequential-2

# 并行运行 (使用 Paratest)
./vendor/bin/phpunit --parallel
```

**测试数据库**:
- SQLite 内存/文件数据库 (`tests/database.sqlite`)
- 使用 Factory 和 Seeder 生成测试数据
- 数据库快照功能 (Spatie Laravel DB Snapshots)

## 重要开发注意事项

### 环境配置

**.env 关键配置**:
```
APP_URL=                    # 应用 URL (CSRF 令牌依赖此设置)
DB_CONNECTION=mysql         # 数据库类型
DB_DATABASE=                # 数据库名
DB_PREFIX=ns_               # 表前缀

# WebSocket (Laravel Reverb)
BROADCAST_DRIVER=reverb
REVERB_APP_ID=
REVERB_APP_KEY=
REVERB_APP_SECRET=

# 队列
QUEUE_CONNECTION=database   # 或 redis
```

**常见问题**:
- **CSRF 错误**: 安装后 URL 改变时,必须更新 `.env` 中的 `APP_URL`
- **无限加载**: 使用 `php artisan serve` 时,数据库配置后重启开发服务器,刷新页面即可
- **模块资源 404**: 运行 `php artisan modules:symlink` 创建符号链接

### 代码风格

**PHP**:
- 遵循 PSR-12 标准
- 使用 Laravel Pint 自动格式化: `./vendor/bin/pint`
- 配置文件: `pint.json`

**TypeScript/JavaScript**:
- ECMAScript 2019+ 目标
- 使用 TypeScript 接口定义数据结构 (`resources/ts/interfaces/`)
- 组件使用 Vue 3 组合式 API

**命名约定**:
- 模型: 单数大写驼峰 (如 `Order`, `Product`)
- 控制器: 复数大写驼峰 + `Controller` (如 `OrdersController`)
- 服务: 复数大写驼峰 + `Service` (如 `OrdersService`)
- 数据库表: 复数蛇形命名 + 前缀 (如 `ns_orders`, `ns_products`)

### 权限系统

- 权限基于角色 (`Role` 模型)
- 使用中间件 `NsRestrictMiddleware` 检查权限
- 权限字符串格式: `nexopos.create.orders`, `nexopos.read.customers`
- 在控制器中使用 `Gate::allows('permission')` 检查

### 钩子使用示例

```php
// 注册过滤器
Hook::addFilter('filter_name', function($value) {
    return $modified_value;
});

// 注册动作
Hook::addAction('action_name', function($data) {
    // 执行操作
});

// 应用过滤器
$result = Hook::filter('filter_name', $value);

// 触发动作
Hook::action('action_name', $data);
```

### 多语言支持

- 语言文件位于 `lang/` (12 种语言)
- 使用 Laravel 本地化: `__('messages.key')`
- 前端使用 `nsLang()` 函数 (在 `libraries/lang.ts`)
- 翻译命令: `php artisan ns:translate --symlink --force`

### 队列和任务

- 队列任务位于 `app/Jobs/`
- 使用 `dispatch()` 分发任务
- 处理器: `php artisan queue:work`
- 队列配置在 `config/queue.php`

## 项目结构要点

```
app/
├── Services/           # 30+ 业务逻辑服务 (核心层)
├── Models/             # 30+ Eloquent 模型
├── Http/Controllers/   # HTTP 控制器 (主要是 CrudController)
├── Http/Middleware/    # 18+ 中间件
├── Crud/               # CRUD 配置类
├── Classes/            # 辅助类 (Hook, Cache, Menu, Form 等)
├── Events/             # 事件类
├── Listeners/          # 事件监听器
├── Exceptions/         # 自定义异常
├── Console/Commands/   # 20+ Artisan 命令
└── Traits/             # 代码复用特性

resources/
├── ts/                 # TypeScript 源代码
│   ├── bootstrap.ts    # 全局初始化
│   ├── app.ts          # 主应用入口
│   ├── pos.ts          # POS 系统入口
│   ├── libraries/      # 20+ 工具库 (http-client, event-emitter, state 等)
│   ├── interfaces/     # TypeScript 接口定义
│   ├── pages/          # Vue 页面组件
│   └── components/     # 全局组件注册
├── css/                # CSS 样式 (app.css, light.css, dark.css)
└── views/              # Blade 模板

database/
├── migrations/
│   ├── core/           # 核心迁移
│   ├── create/         # 创建表
│   └── update/         # 更新表
├── factories/          # 数据工厂
└── seeders/            # 数据填充

modules/                # 可选模块 (通过 module:make 创建)

tests/
└── Feature/            # 50+ 功能测试文件
```

## 文档资源

- **官方文档**: https://my.nexopos.com/en/documentation
- **API 文档**: https://docs.api.nexopos.com
- **创建模块教程**: https://my.nexopos.com/en/documentation/developpers-guides/how-to-create-a-module-for-nexopos-4-x
- **视频教程**: https://www.youtube.com/watch?v=V80-hOJCywY
- **WhatsApp 社区**: https://chat.whatsapp.com/KHWgNmfcfJy7SwJiRQTmG8

## 部署

**DigitalOcean 一键部署**:
- 使用仓库中的 "Deploy to DO" 按钮
- 配置在 `.do/` 目录

**手动部署清单**:
1. 运行 `composer install --optimize-autoloader --no-dev`
2. 运行 `npm run build`
3. 设置 `.env` 配置 (特别是 `APP_URL`)
4. 运行 `php artisan migrate --force`
5. 运行 `php artisan storage:link`
6. 运行 `php artisan ns:translate --symlink --force`
7. 运行 `php artisan modules:symlink`
8. 设置文件权限 (storage/ 和 bootstrap/cache/ 可写)
9. 配置 Web 服务器 (Apache/Nginx) 指向 `public/` 目录
10. 设置 SSL 证书 (建议)
11. 配置队列处理器 (使用 Supervisor)
12. 配置 WebSocket 服务器 (Laravel Reverb)

## 性能优化

**缓存**:
```bash
php artisan config:cache        # 缓存配置
php artisan route:cache         # 缓存路由
php artisan view:cache          # 缓存视图
php artisan optimize            # 优化自动加载
```

**清除缓存**:
```bash
php artisan cache:clear         # 清除应用缓存
php artisan config:clear        # 清除配置缓存
php artisan route:clear         # 清除路由缓存
php artisan view:clear          # 清除视图缓存
```

**数据库优化**:
- 使用 Eloquent 关系预加载避免 N+1 查询
- 为常用查询字段添加索引
- 使用数据库前缀 `ns_` 避免表名冲突

**前端优化**:
- Vite 自动代码分割和懒加载
- 使用 `defineAsyncComponent` 异步加载 Vue 组件
- TailwindCSS 自动清除未使用的样式
