#!/bin/bash

# trae-context-gist 项目配置脚本
# 在现有项目中快速配置全局技能

set -e

echo "======================================"
echo "  trae-context-gist 项目配置工具"
echo "======================================"
echo ""

# 获取当前目录
PROJECT_DIR=$(pwd)

# 检查全局技能是否已安装
if [ ! -d ~/.trae/skills/trae-context-gist ]; then
    echo "❌ 错误：全局技能未安装"
    echo ""
    echo "请先运行全局部署脚本："
    echo "  curl -fsSL https://raw.githubusercontent.com/ethanhuangcst/trae-context-gist/main/deploy-global.sh | bash"
    echo ""
    echo "或手动安装："
    echo "  git clone https://github.com/ethanhuangcst/trae-context-gist.git ~/.trae/skills/trae-context-gist"
    echo "  cd ~/.trae/skills/trae-context-gist && npm install"
    exit 1
fi

echo "✅ 检测到全局技能已安装"
echo ""

# 检查是否已有配置文件
if [ -f .trae/config.json ]; then
    echo "⚠️  检测到现有配置文件"
    echo "位置：$PROJECT_DIR/.trae/config.json"
    echo ""
    
    # 检查是否已包含技能
    if grep -q "trae-context-gist" .trae/config.json; then
        echo "✅ 技能已在配置中"
        exit 0
    fi
    
    read -p "是否添加技能到现有配置？(y/n) " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 已取消"
        exit 1
    fi
    
    # 备份现有配置
    cp .trae/config.json .trae/config.json.backup.$(date +%Y%m%d%H%M%S)
    echo "✅ 已备份现有配置"
    
    # 添加技能到现有配置（需要 jq 工具）
    if command -v jq &> /dev/null; then
        jq '.skills += [{"name": "trae-context-gist", "path": "~/.trae/skills/trae-context-gist", "enabled": true}]' \
            .trae/config.json > .trae/config.json.tmp
        mv .trae/config.json.tmp .trae/config.json
        echo "✅ 已添加技能到配置文件"
    else
        echo "⚠️  未找到 jq 工具，请手动添加以下内容到 .trae/config.json："
        echo ""
        echo '  {"name": "trae-context-gist", "path": "~/.trae/skills/trae-context-gist", "enabled": true}'
        echo ""
        exit 0
    fi
else
    # 创建新的配置文件
    echo "📝 创建配置文件..."
    mkdir -p .trae
    
    cat > .trae/config.json << 'EOF'
{
  "skills": [
    {
      "name": "trae-context-gist",
      "path": "~/.trae/skills/trae-context-gist",
      "enabled": true,
      "schedule": "hourly",
      "description": "自动整理对话上下文并存储到 GitHub Gist"
    }
  ],
  "contextManagement": {
    "autoSummarize": true,
    "summarizeInterval": "hourly",
    "storageProvider": "github-gist",
    "localIndex": true
  }
}
EOF
    
    echo "✅ 已创建配置文件"
fi

# 创建符号链接（可选）
read -p "是否创建符号链接到技能目录？(y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p .trae/skills
    ln -sf ~/.trae/skills/trae-context-gist .trae/skills/trae-context-gist
    echo "✅ 已创建符号链接"
fi

echo ""
echo "======================================"
echo "  ✅ 配置完成！"
echo "======================================"
echo ""
echo "📁 项目目录：$PROJECT_DIR"
echo "📄 配置文件：.trae/config.json"
echo ""
echo "使用方法："
echo "  在 TRAE 中输入 '整理上下文'"
echo ""
echo "查看配置："
echo "  cat .trae/config.json"
echo ""
echo "📖 更多信息："
echo "  https://github.com/ethanhuangcst/trae-context-gist"
echo ""
