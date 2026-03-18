/**
 * 验证本地目录配置
 */

const skill = require('./index.js');

const testConversation = `
用户：测试本地目录配置
助手：好的，我会验证配置
`;

console.log('=== 验证本地目录配置 ===\n');
console.log('配置路径：../../trae-context-gist-notes\n');

skill.execute(testConversation)
  .then(result => {
    console.log('测试结果:');
    if (result.success) {
      console.log('✅ 成功！');
      console.log('📍 本地路径:', result.localPath);
      console.log('☁️  Gist URL:', result.gistUrl || '未同步');
      console.log('📊 同步状态:', result.syncStatus);
    } else {
      console.log('❌ 失败:', result.message);
    }
  })
  .catch(error => {
    console.error('错误:', error.message);
  });
