# 数据库清理指南

## 问题

安装时出现错误：
```
Fatal error: Uncaught mysqli_sql_exception: Table 'piwigo_activity' already exists
```

## 原因

数据库已经部分安装过，存在残留的表。这通常发生在：
- 安装过程中断
- 之前尝试安装过
- 数据库中有旧数据

## 解决方案

### 方案 1: 清理数据库表（推荐）

连接到数据库并删除所有 Piwigo 表：

```sql
-- 连接到数据库
mysql -h mysql3.sqlpub.com -P 3308 -u shigure_shigure -p piwigo_shigure

-- 输入密码: r3rR9AR4U7NVNyHT

-- 删除所有 piwigo_ 前缀的表
DROP TABLE IF EXISTS piwigo_activity;
DROP TABLE IF EXISTS piwigo_categories;
DROP TABLE IF EXISTS piwigo_comments;
DROP TABLE IF EXISTS piwigo_config;
DROP TABLE IF EXISTS piwigo_favorites;
DROP TABLE IF EXISTS piwigo_group_access;
DROP TABLE IF EXISTS piwigo_groups;
DROP TABLE IF EXISTS piwigo_history;
DROP TABLE IF EXISTS piwigo_image_category;
DROP TABLE IF EXISTS piwigo_images;
DROP TABLE IF EXISTS piwigo_languages;
DROP TABLE IF EXISTS piwigo_old_permalinks;
DROP TABLE IF EXISTS piwigo_plugins;
DROP TABLE IF EXISTS piwigo_rate;
DROP TABLE IF EXISTS piwigo_search;
DROP TABLE IF EXISTS piwigo_sessions;
DROP TABLE IF EXISTS piwigo_tags;
DROP TABLE IF EXISTS piwigo_user_access;
DROP TABLE IF EXISTS piwigo_user_cache;
DROP TABLE IF EXISTS piwigo_user_feed;
DROP TABLE IF EXISTS piwigo_user_group;
DROP TABLE IF EXISTS piwigo_user_infos;
DROP TABLE IF EXISTS piwigo_user_mail_notification;
DROP TABLE IF EXISTS piwigo_users;
```

或者使用批量删除：

```sql
-- 生成删除所有表的 SQL
SELECT CONCAT('DROP TABLE IF EXISTS ', table_name, ';')
FROM information_schema.tables
WHERE table_schema = 'piwigo_shigure'
AND table_name LIKE 'piwigo_%';

-- 然后执行生成的 SQL 语句
```

### 方案 2: 使用 MySQL 客户端工具

如果使用 phpMyAdmin 或其他工具：

1. 连接到数据库 `piwigo_shigure`
2. 选择所有 `piwigo_` 开头的表
3. 删除选中的表
4. 重新运行安装

### 方案 3: 创建新的数据库

如果数据不重要，可以创建新的数据库：

```sql
-- 创建新数据库
CREATE DATABASE piwigo_shigure_new;

-- 在安装向导中使用新数据库名
```

### 方案 4: 修改安装脚本（高级）

如果需要保留部分数据，可以修改安装脚本跳过已存在的表，但这不推荐。

## 快速清理脚本

创建一个 SQL 文件 `cleanup.sql`:

```sql
USE piwigo_shigure;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS piwigo_activity;
DROP TABLE IF EXISTS piwigo_categories;
DROP TABLE IF EXISTS piwigo_comments;
DROP TABLE IF EXISTS piwigo_config;
DROP TABLE IF EXISTS piwigo_favorites;
DROP TABLE IF EXISTS piwigo_group_access;
DROP TABLE IF EXISTS piwigo_groups;
DROP TABLE IF EXISTS piwigo_history;
DROP TABLE IF EXISTS piwigo_image_category;
DROP TABLE IF EXISTS piwigo_images;
DROP TABLE IF EXISTS piwigo_languages;
DROP TABLE IF EXISTS piwigo_old_permalinks;
DROP TABLE IF EXISTS piwigo_plugins;
DROP TABLE IF EXISTS piwigo_rate;
DROP TABLE IF EXISTS piwigo_search;
DROP TABLE IF EXISTS piwigo_sessions;
DROP TABLE IF EXISTS piwigo_tags;
DROP TABLE IF EXISTS piwigo_user_access;
DROP TABLE IF EXISTS piwigo_user_cache;
DROP TABLE IF EXISTS piwigo_user_feed;
DROP TABLE IF EXISTS piwigo_user_group;
DROP TABLE IF EXISTS piwigo_user_infos;
DROP TABLE IF EXISTS piwigo_user_mail_notification;
DROP TABLE IF EXISTS piwigo_users;

SET FOREIGN_KEY_CHECKS = 1;
```

执行：

```bash
mysql -h mysql3.sqlpub.com -P 3308 -u shigure_shigure -p piwigo_shigure < cleanup.sql
```

## 验证

清理后，检查表是否已删除：

```sql
SHOW TABLES LIKE 'piwigo_%';
```

应该返回空结果。

## 重新安装

清理完成后：

1. 刷新安装页面
2. 重新填写安装表单
3. 使用相同的数据库配置
4. 安装应该可以正常完成

## 注意事项

- ⚠️ **删除表会丢失所有数据**，如果之前有重要数据，请先备份
- ✅ 清理后可以重新开始安装
- ✅ 使用相同的数据库配置信息

