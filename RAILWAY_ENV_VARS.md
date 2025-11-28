# Railway 环境变量配置

## 问题

如果网页自动跳转到 `install.php`，说明 `PHPWG_INSTALLED` 常量未定义，通常是因为：
1. 环境变量未设置
2. `database.inc.php` 文件未正确创建

## 解决方案

### 在 Railway 中设置环境变量

1. 登录 Railway 控制台
2. 选择你的服务 `piwigo-shigure`
3. 进入 **Variables** 标签
4. 添加以下环境变量：

```
DB_HOST=mysql3.sqlpub.com
DB_PORT=3308
DB_NAME=piwigo_shigure
DB_USER=shigure_shigure
DB_PASSWORD=r3rR9AR4U7NVNyHT
```

### 验证环境变量

部署后，在 Railway 的日志中应该看到：
- ✅ 没有 "ERROR: database.inc.php was not created correctly!" 错误
- ✅ Apache 正常启动

### 检查配置文件

如果仍然跳转到安装页面，可以在 Railway 的 Shell 中检查：

```bash
# 检查文件是否存在
ls -la /var/www/html/local/config/database.inc.php

# 检查文件内容
cat /var/www/html/local/config/database.inc.php

# 应该看到：
# define('PHPWG_INSTALLED', true);
```

### 手动创建配置文件（临时方案）

如果环境变量设置后仍然有问题，可以手动创建：

1. 在 Railway 中打开 Shell
2. 运行：

```bash
mkdir -p /var/www/html/local/config
cat > /var/www/html/local/config/database.inc.php <<'EOF'
<?php
$conf['dblayer'] = 'mysqli';
$conf['db_base'] = 'piwigo_shigure';
$conf['db_user'] = 'shigure_shigure';
$conf['db_password'] = 'r3rR9AR4U7NVNyHT';
$conf['db_host'] = 'mysql3.sqlpub.com:3308';

$prefixeTable = 'piwigo_';

define('PHPWG_INSTALLED', true);
define('PWG_CHARSET', 'utf-8');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
EOF

chown www-data:www-data /var/www/html/local/config/database.inc.php
chmod 644 /var/www/html/local/config/database.inc.php
```

### 注意事项

- ⚠️ 环境变量必须在 Railway 中设置，不能只在代码中硬编码
- ⚠️ 每次重新部署时，`docker-entrypoint.sh` 会重新创建配置文件
- ✅ 如果数据库已安装，设置 `PHPWG_INSTALLED = true` 后应该直接进入网站，而不是安装页面

