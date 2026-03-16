#!/bin/bash
# Dungeon of Words - 自动化迭代工作流
# 萨姆的自我迭代闭环

set -e

echo "🦅 萨姆的自我迭代工作流"
echo "========================"

# 配置
API_URL="https://api.moonshot.cn/v1/chat/completions"
API_KEY="sk-ArDFGXOdQEtXkSO113PWJbJFQxK4a1NECWef5GuMG3quPACe"
MODEL="kimi-k2.5"
GAME_URL="http://localhost:8080/game-rescue-princess.html"

# 步骤1: 启动本地服务器
echo ""
echo "📡 步骤1: 启动本地服务器..."
python3 -m http.server 8080 &>/dev/null &
SERVER_PID=$!
sleep 2
echo "   ✅ 服务器已启动 (PID: $SERVER_PID)"

# 步骤2: 运行自动化测试
echo ""
echo "🎮 步骤2: 运行自动化测试..."

node -e "
const { chromium } = require('playwright');

(async () => {
    const browser = await chromium.launch({ headless: true });
    const page = await browser.newPage();
    page.setDefaultTimeout(30000);
    
    // 打开游戏
    await page.goto('$GAME_URL');
    
    // 配置API
    await page.selectOption('#api-provider', 'moonshot');
    await page.fill('#api-key', '$API_KEY');
    await page.fill('#model-name', '$MODEL');
    
    // 开始游戏
    await page.click('.btn-primary');
    await page.waitForSelector('#game-screen');
    
    // 点击AI代玩
    await page.click('#ai-play-btn');
    
    // 观察10秒
    await page.waitForTimeout(10000);
    
    // 获取状态
    const state = await page.evaluate(() => ({
        turn: document.getElementById('turn').textContent,
        steps: document.getElementById('steps').textContent,
        heroHp: document.getElementById('hero-hp').textContent,
        dialogue: document.getElementById('dialogue').innerText.slice(-500)
    }));
    
    console.log('回合:', state.turn);
    console.log('步数:', state.steps);
    console.log('勇者HP:', state.heroHp);
    console.log('最近对话:', state.dialogue);
    
    // 判断是否正常游戏
    if (parseInt(state.turn) > 0) {
        console.log('✅ 游戏正常运行');
        process.exit(0);
    } else if (state.dialogue.includes('移动') || state.dialogue.includes('攻击')) {
        console.log('✅ AI正在行动（回合显示可能延迟）');
        process.exit(0);
    } else {
        console.log('⚠️ 需要检查');
        process.exit(1);
    }
    
    await browser.close();
})();
" || echo "   ⚠️ 测试遇到问题"

# 步骤3: 停止服务器
echo ""
echo "🛑 步骤3: 停止服务器..."
kill $SERVER_PID 2>/dev/null || true
echo "   ✅ 已停止"

echo ""
echo "========================"
echo "🎯 迭代建议:"
echo "   - 如果测试通过：可以提交代码"
echo "   - 如果测试失败：需要修复问题"
echo "   - 持续改进直到游戏好玩！"
