#!/bin/bash

# trae-context-gist 简单配置脚本
# 在现有项目中快速配置全局技能（无需额外工具）

set -e

PROJECT_DIR=$(pwd)

echo "🚀 配置 trae-context-gist 技能到当前项目"
echo "项目目录：$PROJECT_DIR"
echo ""

# 检查全局技能
if [ ! -d ~/.trae/skills/trae-context-gist ]; then
    echo "❌ 全局技能未安装，正在安装..."
    mkdir -p ~/.trae/skills
    git clone https://github.com/ethanhuangcst/trae-context-gist.git ~/.trae/skills/trae-context-gist
    cd ~/.trae/skills/trae-context-gist
    npm install
    
    if [ ! -f .env ]; then
        echo ""
        echo "🔑 请配置 GitHub Token"
        echo "访问：https://github.com/settings/tokens"
        read -p "输入 Token: " token
        echo "GITHUB_TOKEN=$token" > .env
        chmod 600 .env
    fi
    
    cd "$PROJECT_DIR"
    echo "✅ 全局技能安装完成"
fi

# 创建配置
mkdir -p .trae

if [ -f .trae/config.json ]; then
    echo "⚠️  配置文件已存在，跳过创建"
    echo "如需重新配置，请先删除 .trae/config.json"
else
    cat > .trae/config.json << 'EOF'
{
  "skills": [
    {
      "name": "trae-context-gist",
      "path": "~/.trae/skills/trae-context-gist",
      "enabled": true
    }
  ]
}
EOF
    echo "✅ 配置文件已创建"
fi

echo ""
echo "✅ 完成！现在可以在 TRAE 中使用 '整理上下文' 命令"
