# Railway 部署指南

## 数据库信息

- **主机**: mysql3.sqlpub.com
- **端口**: 3308
- **数据库名**: piwigo_shigure
- **用户名**: shigure_shigure
- **密码**: r3rR9AR4U7NVNyHT

## 部署步骤

### 1. 准备 GitHub 仓库

代码已上传到: https://github.com/Shigure-moon/piwigo-shigure

### 2. 在 Railway 创建项目

1. 访问 https://railway.com/new
2. 点击 "New Project"
3. 选择 "Deploy from GitHub repo"
4. 选择 `Shigure-moon/piwigo-shigure` 仓库

### 3. 配置环境变量

在 Railway 项目设置中添加以下环境变量：

```
DB_HOST=mysql3.sqlpub.com
DB_PORT=3308
DB_NAME=piwigo_shigure
DB_USER=shigure_shigure
DB_PASSWORD=r3rR9AR4U7NVNyHT
```

### 4. 配置服务

Railway 会自动检测 Dockerfile 并构建镜像。

### 5. 首次安装

部署完成后：

1. 访问 Railway 提供的域名
2. 如果看到安装向导，按照提示完成安装
3. 数据库配置会自动从环境变量读取

### 6. 验证部署

- ✅ 网站可以访问
- ✅ 导航栏显示 "shigure" logo
- ✅ 横幅正常显示
- ✅ 相册导航栏（归档、搜索）正常显示

## 故障排除

### 数据库连接失败

1. 检查环境变量是否正确设置
2. 确认数据库服务是否正常运行
3. 检查防火墙设置（Railway 需要能够访问外部 MySQL）

### 文件权限问题

Railway 会自动处理文件权限，如果遇到问题：

1. 检查 `_data` 目录权限
2. 确保 `local/config` 目录可写

### 主题未加载

1. 清除模板缓存：删除 `_data/templates_c/*`
2. 检查主题文件是否正确上传
3. 在 Piwigo 管理后台重新激活主题

## 更新部署

每次推送到 GitHub 主分支，Railway 会自动重新部署。

手动触发部署：
1. 在 Railway 项目页面
2. 点击 "Redeploy"

## 监控和日志

- Railway 提供实时日志查看
- 在项目页面可以查看构建和部署日志
- 可以设置告警通知

## 备份

定期备份：
- 数据库（通过 MySQL 管理工具）
- 上传的图片（`gallery/` 目录）
- 主题自定义文件（已在 Git 中）

