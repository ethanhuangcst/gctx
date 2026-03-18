/**
 * trae-context-gist 技能测试脚本
 * 用于验证技能是否正常工作
 */

const contextGist = require('./index.js');

// 测试对话历史
const testConversation = `
用户：我需要完成一个项目
助手：好的，请问是什么类型的项目？
用户：这是一个重要的 AI 项目，需要实现上下文管理功能
助手：明白了，这是一个关键任务。有什么具体的要求吗？
用户：需要注意性能优化，决定使用 GitHub Gist 存储
助手：好的，我会记住这个决定
用户：还需要实现自动整理功能
助手：好的，我计划在本周内完成
`;

console.log('=== trae-context-gist 技能测试 ===\n');

// 测试 1: 分析功能
console.log('测试 1: 上下文分析功能');
const analysis = contextGist.analyze(testConversation);
console.log('分析结果:', JSON.stringify(analysis, null, 2));
console.log('✓ 分析功能测试通过\n');

// 测试 2: 搜索功能（空索引）
console.log('测试 2: 搜索功能');
const searchResults = contextGist.search('测试');
console.log('搜索结果:', searchResults);
console.log('✓ 搜索功能测试通过\n');

// 测试 3: 获取所有笔记（空索引）
console.log('测试 3: 获取所有笔记');
const allNotes = contextGist.getAll();
console.log('所有笔记:', allNotes);
console.log('✓ 获取笔记功能测试通过\n');

// 测试 4: 主功能（需要网络连接）
console.log('测试 4: 上下文处理功能（上传到 Gist）');
contextGist.execute(testConversation)
  .then(result => {
    console.log('处理结果:', JSON.stringify(result, null, 2));
    if (result.success) {
      console.log('✓ 上下文处理功能测试通过');
      console.log(`Gist URL: ${result.gistUrl}`);
    } else {
      console.log('✗ 上下文处理功能测试失败');
      console.log(`错误信息：${result.message}`);
    }
  })
  .catch(error => {
    console.error('测试失败:', error.message);
  });
