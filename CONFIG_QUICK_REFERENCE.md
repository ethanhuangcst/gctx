# 本地笔记目录配置 - 快速参考

## 一句话说明

在 `.env` 文件中添加 `LOCAL_NOTES_DIR` 即可自定义笔记存储位置。

## 快速配置（3 步）

### 步骤 1：编辑 .env 文件

```bash
nano .trae/skills/trae-context-gist/.env
```

### 步骤 2：添加配置

```bash
# 使用绝对路径
LOCAL_NOTES_DIR=/Users/ethanhuang/Documents/Notes/trae-context

# 或使用相对路径
LOCAL_NOTES_DIR=./data/notes
```

### 步骤 3：测试

```bash
node test.js
```

## 常用配置

### 默认目录
```bash
# 不配置 LOCAL_NOTES_DIR
```
📍 位置：`.trae/skills/trae-context-gist/notes/`

### 项目数据目录
```bash
LOCAL_NOTES_DIR=./data/notes
```
📍 位置：`.trae/skills/trae-context-gist/data/notes/`

### 个人笔记目录
```bash
LOCAL_NOTES_DIR=~/Documents/Notes/trae-context
```
📍 位置：`~/Documents/Notes/trae-context/`

### Dropbox 同步
```bash
LOCAL_NOTES_DIR=~/Dropbox/Notes/trae-context
```
📍 位置：`~/Dropbox/Notes/trae-context/`

### 外部驱动器
```bash
LOCAL_NOTES_DIR=/Volumes/ExternalDrive/Notes
```
📍 位置：`/Volumes/ExternalDrive/Notes/`

## 验证配置

```bash
# 查看配置
grep LOCAL_NOTES_DIR .env

# 运行测试
node test.js

# 查看笔记位置
ls -la $LOCAL_NOTES_DIR
```

## 路径类型

### 绝对路径（推荐）
```bash
LOCAL_NOTES_DIR=/Users/ethanhuang/Documents/Notes
```

### 相对路径
```bash
LOCAL_NOTES_DIR=./notes          # 当前目录
LOCAL_NOTES_DIR=../data          # 上级目录
LOCAL_NOTES_DIR=../../data/notes # 上上级目录
```

## 常见问题

**Q: 目录不存在怎么办？**  
A: 技能会自动创建，无需手动创建

**Q: 需要重启 TRAE 吗？**  
A: 修改 `.env` 后重新运行技能即可

**Q: 可以使用网络路径吗？**  
A: 可以，确保网络驱动器已挂载

**Q: 如何恢复默认？**  
A: 删除或注释掉 `LOCAL_NOTES_DIR` 配置

## 快速测试

```bash
# 使用测试脚本
node test-custom-dir.js
```

## 更多信息

📖 详细指南：[Docs/custom_notes_dir_guide.md](Docs/custom_notes_dir_guide.md)

---

**配置时间**: < 1 分钟  
**难度**: ⭐（非常简单）
