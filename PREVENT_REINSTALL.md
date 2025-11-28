# 防止每次部署都重新安装

## 问题

每次 Railway 重新部署时，Piwigo 都会检测到需要安装，导致：
- 尝试创建已存在的数据库表
- 可能重置数据库配置

## 原因

Piwigo 通过检查 `local/config/database.inc.php` 文件中的 `PHPWG_INSTALLED` 常量来判断是否已安装。

如果文件不存在或常量未定义，会重定向到 `install.php`。

## 解决方案

### ✅ 已修复

1. **更新了 `docker-entrypoint.sh`**:
   - 每次容器启动时都会创建/更新 `database.inc.php`
   - 确保 `PHPWG_INSTALLED` 始终定义为 `true`
   - 从环境变量读取数据库配置

2. **配置持久化**:
   - 数据库配置从环境变量生成，不会丢失
   - 即使容器重启，配置也会自动恢复

## 验证

部署后检查：

1. **访问网站**: 应该直接进入首页，而不是安装页面
2. **检查配置文件**: 
   ```bash
   cat /var/www/html/local/config/database.inc.php
   ```
   应该看到 `define('PHPWG_INSTALLED', true);`

## 如果仍然遇到安装页面

1. **检查环境变量**: 确保 Railway 中设置了所有数据库环境变量
2. **检查文件权限**: 确保 `local/config` 目录可写
3. **查看日志**: 检查容器日志中的错误信息

## 环境变量检查清单

确保 Railway 中设置了：

```
DB_HOST=mysql3.sqlpub.com
DB_PORT=3308
DB_NAME=piwigo_shigure
DB_USER=shigure_shigure
DB_PASSWORD=r3rR9AR4U7NVNyHT
```

## 注意事项

- ✅ 数据库配置会从环境变量自动生成
- ✅ 不会覆盖已安装的数据库
- ✅ 每次部署都会使用最新的环境变量
- ⚠️ 如果数据库表已存在，安装脚本会报错（这是正常的，说明已安装）

## 故障排除

如果看到 "Table already exists" 错误：

1. **这是正常的**: 说明数据库已安装
2. **解决方法**: 直接访问首页，不要访问 `install.php`
3. **或者**: 在 URL 中直接访问 `index.php` 而不是 `install.php`

