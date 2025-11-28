# 干净仓库说明

## 仓库状态

✅ **仓库已清理完成，只保留干净版本**

### 当前状态

- **主分支**: `main`（原 `clean-deploy` 分支）
- **提交历史**: 只包含干净的提交，无敏感信息
- **文件**: 所有部署配置和修复已包含

### 提交历史

1. `7d5d322` - Fix file permissions: ensure local/config directory exists and is writable
2. `6c411e5` - Fix Apache ServerName warning
3. `24b60a6` - Initial commit: Piwigo Shigure custom theme with Railway deployment config

### 已删除

- ❌ 包含敏感 token 的分支和提交
- ❌ `PUSH_TO_GITHUB.md` 文件（包含 token）
- ❌ 所有包含敏感信息的提交

## 文件清单

### 部署文件
- `Dockerfile` - Docker 镜像配置
- `docker-entrypoint.sh` - 容器启动脚本
- `railway.json` - Railway 部署配置
- `.gitignore` - Git 忽略规则

### 文档
- `README.md` - 项目说明
- `RAILWAY_DEPLOYMENT.md` - Railway 部署指南
- `GITHUB_SECRET_FIX.md` - GitHub 推送保护问题说明

## 使用说明

### Railway 部署

1. Railway 已连接到 `main` 分支
2. 每次推送到 `main` 分支会自动触发部署
3. 确保环境变量已正确设置

### 后续更新

```bash
# 添加更改
git add .

# 提交
git commit -m "描述"

# 推送
git push origin main
```

## 安全注意事项

✅ **已移除所有敏感信息**
- 不再包含 GitHub token
- 不再包含数据库密码（使用环境变量）
- 所有敏感信息通过环境变量配置

## 验证

访问 https://github.com/Shigure-moon/piwigo-shigure 确认：
- ✅ 只有 `main` 分支
- ✅ 提交历史干净
- ✅ 无敏感信息

