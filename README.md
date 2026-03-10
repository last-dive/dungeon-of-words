# 🏰 Dungeon of Words

> 文字地牢 - AI NPC 文字冒险游戏

<p align="center">
  <img src="https://img.shields.io/badge/LLM-NPC-Game-blue" alt="LLM NPC Game">
  <img src="https://img.shields.io/badge/HTML5-JavaScript-green" alt="HTML5">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">
</p>

## ✨ 简介

**Dungeon of Words** (文字地牢) 是一款基于大语言模型 (LLM) 驱动的 AI NPC 文字冒险游戏。

玩家扮演勇者，在 5×5 的地牢地图中探索，与 AI 驱动的 NPC 互动，拯救被囚禁的公主。

### 🎮 核心特色

- **AI NPC 对话**: 所有 NPC (法师 Merlin、Boss 黑暗龙王、公主 Elara) 均由你的大模型驱动
- **动态战斗**: 回合制战斗系统，支持物理攻击和魔法
- **随机地图**: 每次游戏地图、Boss、公主位置、怪物分布随机生成
- **记忆系统**: NPC 会记住游戏中的关键信息
- **本地运行**: 所有数据保存在浏览器本地，API Key 不上传服务器

### 🤖 AI NPC 设计

本项目是 AI NPC 技术的实验性应用，核心设计理念：

1. **人格一致性**: 每个 NPC 有明确的 system prompt 定义性格
2. **游戏目标关联**: NPC 的行为和对话与游戏目标紧密关联
3. **记忆传递**: 关键信息 (如公主位置) 通过 NPC 对话传递给玩家
4. **实时响应**: 使用 LLM API 动态生成对话

详见 [NPC设计文档](./docs/NPC_DESIGN.md)

## 🚀 快速开始

### 方式一：直接打开

1. 下载 `game-rescue-princess.html`
2. 用浏览器直接打开
3. 输入你的 API Key 开始游戏

### 方式二：本地运行服务器

```bash
# 克隆仓库
git clone https://github.com/last-dive/dungeon-of-words.git
cd dungeon-of-words

# 用 Python 启动简单服务器
python3 -m http.server 8080

# 浏览器打开 http://localhost:8080
```

## 📖 游戏说明

### 操作

| 按钮 | 功能 |
|------|------|
| ⚔️ 攻击 | 对当前格子的敌人造成伤害 |
| ✨ 魔法 | 法师使用魔法 (治疗/攻击) |
| 👣 移动 | 输入方向移动 (上/下/左/右) |
| 💬 对话 | 与附近 NPC AI 对话 |

### 游戏目标

1. 在 50 步内找到公主位置
2. 击败 Boss 黑暗龙王
3. 找到并接触公主获胜

### NPC

- **🧙 Merlin (法师)**: 忠诚的伙伴，提供魔法支援和战术建议
- **👹 Azathoth (黑暗龙王)**: 傲慢的 Boss，守卫着公主
- **👸 Elara (公主)**: 被囚禁的公主，等待勇者救援

## 🔧 API 配置

支持任意 OpenAI 兼容的 LLM API：

| 类型 | URL 示例 | 模型示例 |
|------|----------|----------|
| OpenAI | `https://api.openai.com/v1` | `gpt-4o-mini` |
| Anthropic | `https://api.anthropic.com/v1` | `claude-3-haiku` |
| 本地 | `http://localhost:1234/v1` | `gpt-4o-mini` |

## 🎯 技术栈

- **前端**: 原生 HTML5 + CSS3 + JavaScript
- **AI**: OpenAI 兼容 API (任意 LLM)
- **架构**: 单文件，无需后端

## 📝 项目结构

```
dungeon-of-words/
├── game-rescue-princess.html   # 游戏主文件 (单HTML)
├── README.md                    # 本文档
└── docs/
    └── NPC_DESIGN.md           # NPC 设计文档
```

## 🔬 设计与研究

本项目是 **AI NPC 游戏应用** 的探索性实验，核心研究问题：

1. LLM 能否驱动游戏 NPC 的对话和行为？
2. 如何确保 NPC 的人格一致性？
3. 如何让 NPC 的行为与游戏目标关联？
4. 玩家对 AI NPC 的体验如何？

详见博客文章: [AI NPC 设计思考](./docs/NPC_DESIGN.md)

## 🤝 贡献

欢迎提交 Issue 和 PR！

## 📜 许可证

MIT License

---

<p align="center">
 Made with ❤️ by Sam (萨姆) - AI NPC Research Project
</p>
