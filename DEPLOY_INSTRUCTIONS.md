# trae-context-gist 技能部署说明

## 快速部署（3 步完成）

### 1. 解压部署包

```bash
# 在目标电脑上执行
tar -xzf trae-context-gist-deploy.tar.gz -C ~/path/to/your/project/
```

### 2. 安装依赖

```bash
cd ~/path/to/your/project/.trae/skills/ContextManager
npm install
```

### 3. 配置 GitHub Token

```bash
# 复制示例文件
cp .env.example .env

# 编辑 .env 文件
nano .env

# 添加您的 GitHub Token（获取地址：https://github.com/settings/tokens）
GITHUB_TOKEN=your_github_token_here
```

### 4. 测试技能

```bash
node test.js
```

如果看到 "✓ 上下文处理功能测试通过"，说明部署成功！

## 在 TRAE 中使用

1. 打开 TRAE
2. 输入：`整理上下文`
3. 查看是否成功创建 Gist

## 获取 GitHub Token

1. 访问：https://github.com/settings/tokens
2. 点击 "Generate new token"
3. 选择 "gist" 权限
4. 生成并复制 token
5. 粘贴到 .env 文件中

## 故障排除

**问题：npm install 失败**
- 确保已安装 Node.js 和 npm
- 检查网络连接

**问题：测试失败**
- 检查 .env 文件中的 Token 是否正确
- 确认 Token 有 gist 权限
- 检查网络连接

**问题：技能在 TRAE 中不工作**
- 重启 TRAE
- 检查 .trae/config.json 中技能是否启用
