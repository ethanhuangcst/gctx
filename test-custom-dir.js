/**
 * 测试自定义本地笔记目录功能
 */

const fs = require('fs');
const path = require('path');

// 设置自定义目录
const customDir = path.join(__dirname, 'test-custom-notes');
process.env.LOCAL_NOTES_DIR = customDir;

console.log('=== 测试自定义本地笔记目录 ===\n');

// 加载技能
const skill = require('./index.js');

// 测试对话
const testConversation = `
用户：测试自定义目录
助手：好的，我会测试自定义目录功能
用户：这是一个重要测试
`;

// 测试
console.log('使用自定义目录:', customDir);
console.log('');

skill.execute(testConversation)
  .then(result => {
    console.log('处理结果:', JSON.stringify(result, null, 2));
    console.log('');
    
    if (result.success) {
      console.log('✓ 测试通过');
      console.log('');
      
      // 验证文件是否保存在自定义目录
      if (result.localPath.includes('test-custom-notes')) {
        console.log('✓ 笔记已保存到自定义目录');
        
        // 检查自定义目录是否存在
        if (fs.existsSync(customDir)) {
          console.log('✓ 自定义目录已创建');
          
          // 列出目录内容
          const files = fs.readdirSync(customDir);
          console.log('目录内容:', files);
        } else {
          console.log('✗ 自定义目录未创建');
        }
      } else {
        console.log('✗ 笔记未保存到自定义目录');
      }
      
      // 清理测试目录
      if (fs.existsSync(customDir)) {
        console.log('');
        console.log('清理测试目录...');
        fs.rmSync(customDir, { recursive: true, force: true });
        console.log('✓ 测试目录已清理');
      }
    } else {
      console.log('✗ 测试失败:', result.message);
    }
  })
  .catch(error => {
    console.error('测试出错:', error.message);
  });
