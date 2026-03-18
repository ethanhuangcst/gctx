#!/bin/bash

# trae-context-gist 技能部署脚本
# 用法：./deploy.sh [目标目录]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}trae-context-gist 技能部署脚本${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""

# 获取当前目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SKILL_DIR="$SCRIPT_DIR"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# 检查技能目录是否存在
if [ ! -d "$SKILL_DIR" ]; then
    echo -e "${RED}错误：找不到技能目录 $SKILL_DIR${NC}"
    exit 1
fi

echo -e "${YELLOW}步骤 1/5: 准备部署文件...${NC}"

# 创建临时部署目录
DEPLOY_TEMP=$(mktemp -d)
mkdir -p "$DEPLOY_TEMP/.trae/skills/ContextManager"

# 复制必要文件（排除不必要的）
cp "$SKILL_DIR/.env.example" "$DEPLOY_TEMP/.trae/skills/ContextManager/"
cp "$SKILL_DIR/SKILL.md" "$DEPLOY_TEMP/.trae/skills/ContextManager/"
cp "$SKILL_DIR/index.js" "$DEPLOY_TEMP/.trae/skills/ContextManager/"
cp "$SKILL_DIR/package.json" "$DEPLOY_TEMP/.trae/skills/ContextManager/"
cp "$SKILL_DIR/README.md" "$DEPLOY_TEMP/.trae/skills/ContextManager/"
cp "$SKILL_DIR/test.js" "$DEPLOY_TEMP/.trae/skills/ContextManager/"

# 复制配置文件
cp "$PROJECT_DIR/.trae/config.json" "$DEPLOY_TEMP/.trae/"

echo -e "${GREEN}✓ 文件准备完成${NC}"
echo ""

# 创建压缩包
echo -e "${YELLOW}步骤 2/5: 创建部署包...${NC}"
cd "$DEPLOY_TEMP"
tar -czf "$SCRIPT_DIR/trae-context-gist-deploy.tar.gz" .trae/
cd "$SCRIPT_DIR"
rm -rf "$DEPLOY_TEMP"

echo -e "${GREEN}✓ 部署包已创建：trae-context-gist-deploy.tar.gz${NC}"
echo ""

# 创建部署说明文件
cat > "$SCRIPT_DIR/DEPLOY_INSTRUCTIONS.md" << 'EOF'
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
EOF

echo -e "${GREEN}✓ 部署说明已创建：DEPLOY_INSTRUCTIONS.md${NC}"
echo ""

# 创建 Windows 部署脚本
cat > "$SCRIPT_DIR/deploy-windows.ps1" << 'EOF'
# trae-context-gist Windows 部署脚本
# 用法：.\deploy-windows.ps1 <目标目录>

param(
    [string]$TargetDir
)

Write-Host "======================================" -ForegroundColor Green
Write-Host "trae-context-gist 技能部署脚本 (Windows)" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

if (-not $TargetDir) {
    Write-Host "用法：.\deploy-windows.ps1 <目标目录>" -ForegroundColor Red
    exit 1
}

# 创建目录
Write-Host "步骤 1/4: 创建目录..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "$TargetDir\.trae\skills\ContextManager" | Out-Null
Write-Host "✓ 目录创建完成" -ForegroundColor Green
Write-Host ""

# 复制文件
Write-Host "步骤 2/4: 复制文件..." -ForegroundColor Yellow
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Copy-Item -Path "$ScriptDir\.trae\skills\ContextManager\.env.example" -Destination "$TargetDir\.trae\skills\ContextManager\" -Force
Copy-Item -Path "$ScriptDir\.trae\skills\ContextManager\SKILL.md" -Destination "$TargetDir\.trae\skills\ContextManager\" -Force
Copy-Item -Path "$ScriptDir\.trae\skills\ContextManager\index.js" -Destination "$TargetDir\.trae\skills\ContextManager\" -Force
Copy-Item -Path "$ScriptDir\.trae\skills\ContextManager\package.json" -Destination "$TargetDir\.trae\skills\ContextManager\" -Force
Copy-Item -Path "$ScriptDir\.trae\skills\ContextManager\README.md" -Destination "$TargetDir\.trae\skills\ContextManager\" -Force
Copy-Item -Path "$ScriptDir\.trae\skills\ContextManager\test.js" -Destination "$TargetDir\.trae\skills\ContextManager\" -Force
Copy-Item -Path "$ScriptDir\.trae\config.json" -Destination "$TargetDir\.trae\" -Force
Write-Host "✓ 文件复制完成" -ForegroundColor Green
Write-Host ""

# 安装依赖
Write-Host "步骤 3/4: 安装依赖..." -ForegroundColor Yellow
Set-Location "$TargetDir\.trae\skills\ContextManager"
npm install
Write-Host "✓ 依赖安装完成" -ForegroundColor Green
Write-Host ""

# 创建 .env 文件
Write-Host "步骤 4/4: 配置 GitHub Token..." -ForegroundColor Yellow
Copy-Item ".env.example" ".env"
Write-Host "请编辑 .env 文件并添加 GitHub Token" -ForegroundColor Cyan
Write-Host "获取 Token: https://github.com/settings/tokens" -ForegroundColor Cyan
Write-Host ""

Write-Host "======================================" -ForegroundColor Green
Write-Host "部署完成！" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "下一步：" -ForegroundColor Yellow
Write-Host "1. 编辑 .env 文件，添加 GitHub Token" -ForegroundColor White
Write-Host "2. 运行 'node test.js' 测试技能" -ForegroundColor White
Write-Host "3. 在 TRAE 中输入 '整理上下文' 使用技能" -ForegroundColor White
Write-Host ""
EOF

echo -e "${GREEN}✓ Windows 部署脚本已创建：deploy-windows.ps1${NC}"
echo ""

# 输出总结
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}部署准备完成！${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo -e "${YELLOW}已创建以下文件：${NC}"
echo "  1. trae-context-gist-deploy.tar.gz  - 部署包"
echo "  2. DEPLOY_INSTRUCTIONS.md           - 部署说明"
echo "  3. deploy-windows.ps1               - Windows 部署脚本"
echo ""
echo -e "${YELLOW}在其他电脑上部署：${NC}"
echo ""
echo -e "${GREEN}macOS/Linux:${NC}"
echo "  1. 将部署包复制到目标电脑"
echo "  2. 解压：tar -xzf trae-context-gist-deploy.tar.gz -C ~/path/to/project/"
echo "  3. cd ~/path/to/project/.trae/skills/ContextManager"
echo "  4. npm install"
echo "  5. cp .env.example .env"
echo "  6. 编辑 .env 添加 GitHub Token"
echo "  7. node test.js"
echo ""
echo -e "${GREEN}Windows:${NC}"
echo "  1. 将部署包和解压到目标电脑"
echo "  2. 运行：.\\deploy-windows.ps1 <目标目录>"
echo "  3. 按照提示配置 GitHub Token"
echo ""
echo -e "${YELLOW}详细文档：${NC}"
echo "  请查看：Docs/deployment_guide.md"
echo ""
