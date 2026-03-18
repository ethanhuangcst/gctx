/**
 * 测试 iCloud 同步目录配置
 */

const skill = require('./index.js');

const testConversation = `
用户：测试 iCloud 同步目录配置
助手：好的，我会验证笔记是否保存到 iCloud 同步目录
用户：目录路径：/Users/ethanhuang/Documents/Ethan's Workspace/trae-context-gist/notes
`;

console.log('=== 测试 iCloud 同步目录配置 ===\n');
console.log('配置的目录：/Users/ethanhuang/Documents/Ethan\'s Workspace/trae-context-gist/notes\n');

skill.execute(testConversation)
  .then(result => {
    console.log('处理结果:');
    console.log(JSON.stringify(result, null, 2));
    console.log('');
    
    if (result.success) {
      const expectedPath = '/Users/ethanhuang/Documents/Ethan\'s Workspace/trae-context-gist/notes';
      
      if (result.localPath.includes('trae-context-gist/notes')) {
        console.log('✅ 成功！笔记已保存到 iCloud 同步目录');
        console.log('📍 位置:', result.localPath);
        console.log('');
        console.log('🎉 iCloud 会自动同步这个目录中的笔记文件！');
      } else {
        console.log('❌ 笔记未保存到配置的目录');
        console.log('📍 实际位置:', result.localPath);
      }
    } else {
      console.log('❌ 处理失败:', result.message);
    }
  })
  .catch(error => {
    console.error('测试出错:', error.message);
  });
