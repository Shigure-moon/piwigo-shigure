# 相册图片设置说明

## ✅ 已完成

- ✅ "智能可穿戴实验室" 相册图片已上传到 GitHub
- ✅ Dockerfile 已更新，构建时会包含图片
- ✅ 共 35 张图片（约 73MB）

## 图片位置

- **GitHub**: `gallery/galleries/智能可穿戴实验室/`
- **容器内**: `/var/www/html/galleries/智能可穿戴实验室/`

## 部署流程

1. **Railway 自动构建**:
   - Railway 会从 GitHub 拉取代码
   - Docker 构建时会复制图片到容器
   - 图片会出现在 `/var/www/html/galleries/智能可穿戴实验室/`

2. **在 Piwigo 中同步**:
   - 登录管理后台
   - 进入 "管理" > "同步"
   - 选择相册 "智能可穿戴实验室"
   - 点击 "同步" 按钮
   - 图片会自动导入到数据库

## 验证

部署后检查：

```bash
# 在 Railway 容器中
ls -la /var/www/html/galleries/智能可穿戴实验室/
```

应该看到 35 个图片文件。

## 注意事项

- 图片已包含在 Docker 镜像中，每次部署都会包含
- 如果添加新图片，需要：
  1. 将图片复制到 `gallery/galleries/智能可穿戴实验室/`
  2. 提交并推送到 GitHub
  3. Railway 会自动重新部署
  4. 在管理后台同步新图片

## 添加更多相册

如果将来要添加其他相册：

1. 将图片复制到 `gallery/galleries/新相册名称/`
2. 更新 `.gitignore` 添加例外：
   ```
   !gallery/galleries/新相册名称
   !gallery/galleries/新相册名称/**
   ```
3. 提交并推送

