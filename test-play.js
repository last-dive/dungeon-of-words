/**
 * Dungeon of Words - 自动测试脚本
 * 萨姆自己玩游戏
 */

const { chromium } = require('playwright');

const API_CONFIG = {
    provider: 'moonshot',
    apiUrl: 'https://api.moonshot.cn/v1/chat/completions',
    apiKey: 'sk-ArDFGXOdQEtXkSO113PWJbJFQxK4a1NECWef5GuMG3quPACe',
    model: 'kimi-k2.5'
};

async function runTest() {
    console.log('🚀 启动浏览器...');
    const browser = await chromium.launch({ headless: false });
    const page = await browser.newPage();
    
    // 设置更长的超时
    page.setDefaultTimeout(60000);
    
    // 打开本地游戏页面
    console.log('📂 打开本地游戏...');
    await page.goto('http://localhost:8080/game-rescue-princess.html', { waitUntil: 'networkidle' });
    
    // 等待页面加载
    console.log('✅ 登录页面加载完成');
    
    // 填写 API 配置
    console.log('⚙️ 填写 API 配置...');
    await page.selectOption('#api-provider', API_CONFIG.provider);
    await page.fill('#api-key', API_CONFIG.apiKey);
    await page.fill('#model-name', API_CONFIG.model);
    
    // 点击开始游戏
    console.log('🎮 点击开始游戏...');
    await page.click('.btn-primary');
    
    // 等待游戏界面加载
    await page.waitForSelector('#game-screen', { timeout: 30000 });
    console.log('✅ 游戏开始！');
    
    // 点击"让我来玩"按钮
    console.log('🦅 点击"让我来玩"...');
    await page.click('#ai-play-btn');
    
    // 观看 AI 玩游戏 (60秒)
    console.log('⏳ 观看 AI 玩游戏 (60秒)...');
    for (let i = 0; i < 6; i++) {
        await page.waitForTimeout(10000);
        try {
            const state = await page.evaluate(() => ({
                turn: document.getElementById('turn')?.textContent,
                steps: document.getElementById('steps')?.textContent,
                heroHp: document.getElementById('hero-hp')?.textContent,
                bossHp: document.getElementById('boss-hp')?.textContent
            }));
            console.log(`   [${i*10+10}s] 回合:${state.turn} 步数:${state.steps} 勇者:${state.heroHp} Boss:${state.bossHp}`);
        } catch(e) {}
    }
    
    // 截图保存
    await page.screenshot({ path: 'game-screenshot.png', fullPage: true });
    console.log('📸 截图已保存: game-screenshot.png');
    
    // 获取对话日志
    const dialogues = await page.evaluate(() => {
        const container = document.getElementById('dialogue');
        return container ? container.innerText : '';
    });
    
    console.log('💬 最近对话:');
    console.log(dialogues.slice(-2000));
    
    console.log('✅ 测试完成！');
}

runTest().catch(e => {
    console.error('错误:', e.message);
    process.exit(1);
});
