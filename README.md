# trae-context-gist

TRAE CN 上下文管理工具 - 整理对话上下文并同步到 GitHub Gist

## 安装

```bash
# 全局安装
npm install -g trae-context-gist

# 或使用 npx（无需安装）
npx trae-context-gist --help
```

## 快速开始

```bash
# 1. 配置 GitHub Token
trae-context-gist config --token ghp_your_token_here

# 2. 同步上下文
trae-context-gist sync

# 3. 查看笔记列表
trae-context-gist list
```

## 命令

### `sync` - 同步上下文

```bash
trae-context-gist sync [options]

选项:
  -p, --project <name>  指定项目名称（默认从当前目录提取）
  -d, --dir <path>      指定笔记存储目录
```

### `list` - 列出笔记

```bash
trae-context-gist list [options]

选项:
  -p, --project <name>  筛选指定项目的笔记
  -l, --local           只显示本地笔记
```

### `config` - 配置

```bash
trae-context-gist config [options]

选项:
  -t, --token <token>   设置 GitHub Token
  -s, --show            显示当前配置
```

### `init` - 初始化项目

```bash
trae-context-gist init
```

## 获取 GitHub Token

1. 访问 https://github.com/settings/tokens/new
2. Note: `trae-context-gist`
3. Expiration: 选择 `Custom` → 设置 1 年后
4. Select scopes: ✅ `gist`
5. 点击 Generate token，复制保存

## 目录结构

```
~/.trae-context-gist/           # 全局配置目录
├── config.json                 # 配置文件（Token）
└── gist-mapping.json           # 项目-Gist 映射

your-project/
└── trae-content-gist-notes/    # 本地笔记
    ├── context_2026-03-20.json
    └── ...
```

## 与 TRAE 集成

在 TRAE 对话中：

```
用户: 请帮我同步上下文
AI: 好的，我来执行同步命令...
[运行] npx trae-context-gist sync
[结果] 上下文已同步到 Gist: https://gist.github.com/xxx
```

## 故障排除

| 问题 | 解决方案 |
|------|---------|
| Token 未配置 | 运行 `trae-context-gist config --token <your-token>` |
| 笔记位置错误 | 检查项目根目录下的 `trae-content-gist-notes/` |
| Gist 上传失败 | 检查 Token 权限和有效期；本地笔记仍可用 |

---

**GitHub**: https://github.com/ethanhuangcst/trae-context-gist
