---
name: dispatch-task
description: 钢铁侠派单模板，包含完整的 Constraints 和双重汇报命令，派单前必须加载并逐条确认
tags:
  - workflow
  - dispatch
  - template
---

# 钢铁侠派单模板

> **触发条件**：钢铁侠派发任何任务前必须加载此 skill
> **铁律**：派单内容必须从此模板复制，不允许凭记忆简化

---

## 一、完整派单模板

### 1.1 写任务模板（修改文件/代码/配置）

```text
[TASK] [项目名] @目标Bot

📌 Context:
- 执行节点: [奥创/贾维斯]
- 执行路径: [具体路径，如 ~/workspace/programs/xxx/]
- 依赖任务: [如有]

🎯 Task:
1. git pull 拉取最新规则
2. [具体步骤...]

⛔ Constraints:
- 汇报必须 @TMYhermes_bot，否则视为未收到
- 必须 git push（只commit不push = 未完成）
- Output 首行 Status: SUCCESS/FAILED
- **双重汇报（必做）**：
  1. Redis通知：`python3 03-ops/scripts/task_report.py notify <project> <phase> <node> <commit>`（触发自动验收）
  2. 群聊汇报：`@TMYhermes_bot 工作完毕 (Commit: <hash>)`
- 记忆声明: 写入shared-memory 或 "无新记忆"

🔄 Rollback: [回滚方式]

✅ 完成后: @TMYhermes_bot + 验证结果
```

### 1.2 只读任务模板（查询/检查/同步规则）

```text
[TASK] [项目名] @目标Bot

📌 Context:
- 执行节点: [奥创/贾维斯]
- 执行路径: [具体路径]
- 任务类型: 只读（不修改文件）

🎯 Task:
1. [具体步骤...]

⛔ Constraints:
- 汇报必须 @TMYhermes_bot，否则视为未收到
- 不需要 git push（只读任务）
- 直接贴验证命令输出
- 记忆声明: 无新记忆

✅ 完成后: @TMYhermes_bot + 命令输出结果
```

**只读任务不需要**：
- Redis 通知
- output 文件
- commit hash

---

## 二、发前必过清单（逐条确认）

派单前必须口头确认：

- [ ] **任务类型**: 写任务 or 只读任务？
- [ ] **目标检查**: 唯一执行人、节点匹配
- [ ] **格式检查**: 首字符是 @、无前置空行
- [ ] **Context必含**: 执行节点、执行路径
- [ ] **Constraints必含**:
  - 写任务: @TMYhermes_bot、git push、双重汇报、记忆声明
  - 只读任务: @TMYhermes_bot、贴输出
- [ ] **路径规范**: 执行路径符合 §5.4 规定

---

## 三、双重汇报命令

**Redis 通知**（触发自动验收）：
```bash
python3 03-ops/scripts/task_report.py notify <project> <phase> <node> <commit>
```

**群聊汇报**：
```
@TMYhermes_bot 工作完毕 (Commit: <hash>)
```

---

## 四、违规记录

| 日期 | 问题 | 后果 |
|------|------|------|
| 2026-10-14 | 派单缺少双重汇报要求 | 执行者不发 Redis，验收不触发 |
| 2026-10-14 | 凭记忆简化派单内容 | 模板未执行 |

**铁律**：不执行模板 = 不合格指挥官