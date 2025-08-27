# MCB 数据库迁移脚本

本目录包含Flyway数据库迁移脚本，按版本号顺序执行。

## 迁移脚本列表

| 版本 | 文件名 | 描述 |
|------|--------|------|
| V1 | `V1__Create_users_table.sql` | 创建用户表 |
| V2 | `V2__Create_category_table.sql` | 创建分类表 |
| V3 | `V3__Create_exchange_rate_table.sql` | 创建汇率表 |
| V4 | `V4__Create_transaction_table.sql` | 创建交易记录表 |
| V5 | `V5__Insert_default_categories.sql` | 插入默认分类数据 |
| V6 | `V6__Insert_sample_data.sql` | 插入示例数据 (仅开发环境) |

## 数据库结构说明

### 表关系
- `users` (1) → (N) `category` 
- `users` (1) → (N) `transaction`
- `category` (1) → (N) `transaction`
- `exchange_rate` 独立表，存储汇率信息

### 字段说明
- **金额存储**: 使用最小货币单位存储 (如分、分)，避免小数精度问题
- **货币代码**: 使用3位ISO 4217标准货币代码 (USD, CNY, CAD等)
- **汇率精度**: 精确到8位小数
- **时间戳**: 使用带时区的时间戳格式

## 环境配置

### 开发环境
- 包含示例数据 (V6)
- 包含演示用户账户

### 生产环境
- 删除或忽略 V6 示例数据脚本
- 确保所有敏感数据通过环境变量配置

## 注意事项

1. **不要修改已执行的迁移脚本** - 如需更改，请创建新的迁移脚本
2. **生产环境部署前** - 请删除或重命名V6示例数据脚本
3. **外键约束** - 分类删除使用RESTRICT，用户删除使用CASCADE
4. **索引优化** - 已为常用查询创建复合索引