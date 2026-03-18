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
