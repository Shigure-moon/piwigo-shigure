# 修复中文名称同步问题

## 问题

1. **中文名称错误**: Piwigo 默认只允许 `[a-zA-Z0-9-_.]` 字符，不支持中文
2. **同步路径错误**: `PWG-ERROR-NO-FS` 表示无法访问 galleries 目录

## 解决方案

### ✅ 已修复

1. **创建了 `config/www/local/config/config.inc.php`**:
   - 修改 `sync_chars_regex` 以支持 Unicode 字符（包括中文）
   - 使用正则表达式: `/^[-_.\p{L}\p{N}\p{Z}()\[\]]+$/u`
   - `\p{L}` = Unicode 字母（包括中文）
   - `\p{N}` = Unicode 数字
   - `\p{Z}` = Unicode 空格
   - `u` 标志 = UTF-8 模式

2. **确保配置文件被包含**:
   - 配置文件位于 `config/www/local/config/config.inc.php`
   - Piwigo 会自动加载此文件（在 `common.inc.php` 中）

## 在 Piwigo 管理后台配置

### 1. 设置同步路径

1. 登录管理后台
2. 进入 **管理** > **同步** (或访问 `admin.php?page=sites`)
3. 如果还没有配置同步站点，点击 **添加新站点**
4. 设置：
   - **类型**: 本地文件系统
   - **URL/路径**: `./galleries/` 或 `/var/www/html/galleries/`
   - **名称**: 智能可穿戴实验室

### 2. 执行同步

1. 选择刚创建的站点
2. 点击 **同步**
3. 选择：
   - ✅ **目录/文件** (必须)
   - ✅ **元数据** (可选)
4. 点击 **提交**

## 验证

同步后应该看到：
- ✅ 1 个相册已添加到数据库（智能可穿戴实验室）
- ✅ 35 张图片已添加到数据库
- ❌ 0 个错误

## 如果仍然遇到问题

### 检查配置文件

在容器中检查：
```bash
cat /var/www/html/local/config/config.inc.php
```

应该看到：
```php
$conf['sync_chars_regex'] = '/^[-_.\p{L}\p{N}\p{Z}()\[\]]+$/u';
```

### 检查 galleries 路径

在容器中检查：
```bash
ls -la /var/www/html/galleries/智能可穿戴实验室/
```

应该看到 35 个图片文件。

### 检查权限

确保 galleries 目录可读：
```bash
chmod -R 755 /var/www/html/galleries
chown -R www-data:www-data /var/www/html/galleries
```

## 注意事项

- ✅ 配置文件已包含在 Docker 镜像中
- ✅ 每次部署都会自动包含此配置
- ⚠️ 如果修改了配置，需要重新部署

