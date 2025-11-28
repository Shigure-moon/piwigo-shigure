# 检查安装状态

## 日志分析

从你提供的日志来看：
```
[Fri Nov 28 06:54:46.559045 2025] [mpm_prefork:notice] [pid 1:tid 1] AH00163: Apache/2.4.65 (Debian) PHP/8.1.33 configured -- resuming normal operations
100.64.0.2 - - [28/Nov/2025:06:55:32 +0000] "GET /install.php HTTP/1.1" 200 4101
```

**这是正常的**，如果：
- ✅ Apache 正常启动（没有错误）
- ⚠️ 访问 `/install.php` 返回 200（说明页面可以访问）

## 问题诊断

如果网站自动跳转到 `install.php`，可能的原因：

### 1. 环境变量未设置

**检查方法**：
1. 在 Railway 控制台查看 **Variables** 标签
2. 确认是否设置了：
   - `DB_HOST`
   - `DB_PORT`
   - `DB_NAME`
   - `DB_USER`
   - `DB_PASSWORD`

### 2. 配置文件未正确创建

**检查方法**（在 Railway Shell 中）：
```bash
# 检查文件是否存在
ls -la /var/www/html/local/config/database.inc.php

# 检查文件内容
cat /var/www/html/local/config/database.inc.php

# 应该看到：
# define('PHPWG_INSTALLED', true);
```

### 3. 环境变量为空

即使设置了环境变量，如果值为空，也会导致问题。

**检查方法**（在 Railway Shell 中）：
```bash
# 检查环境变量
env | grep DB_

# 应该看到：
# DB_HOST=mysql3.sqlpub.com
# DB_PORT=3308
# DB_NAME=piwigo_shigure
# DB_USER=shigure_shigure
# DB_PASSWORD=r3rR9AR4U7NVNyHT
```

## 解决方案

### 如果环境变量未设置：

1. 在 Railway 控制台设置环境变量（参考 `RAILWAY_ENV_VARS.md`）
2. 等待自动重新部署
3. 访问网站，应该直接进入首页

### 如果环境变量已设置但仍然跳转：

1. **检查 Railway 日志**：
   - 查看是否有 "ERROR: database.inc.php was not created correctly!" 错误
   - 查看是否有其他 PHP 错误

2. **手动检查配置文件**（在 Railway Shell 中）：
   ```bash
   cat /var/www/html/local/config/database.inc.php
   ```

3. **如果文件不存在或内容错误**：
   - 检查环境变量是否正确设置
   - 检查文件权限：
     ```bash
     ls -la /var/www/html/local/config/
     chmod 644 /var/www/html/local/config/database.inc.php
     chown www-data:www-data /var/www/html/local/config/database.inc.php
     ```

## 正常情况

如果一切正常，你应该看到：
- ✅ Apache 正常启动（无错误）
- ✅ 访问网站直接进入首页（不是 install.php）
- ✅ 可以正常浏览相册

## 下一步

1. **确认环境变量已设置**（最重要！）
2. **等待 Railway 重新部署**
3. **访问网站测试**

如果环境变量已设置但仍然跳转到 install.php，请提供：
- Railway 日志中的错误信息
- `database.inc.php` 文件的内容

