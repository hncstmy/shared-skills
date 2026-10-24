# 三节点共享技能库

> 用途：钢铁侠/奥创/贾维斯三节点共享通用 Skill

---

## 目录结构

```
shared-skills/
├── skills/
│   ├── hindsight-memory/
│   │   └── SKILL.md
│   └── ...
├── scripts/
│   └── sync-skills.sh
└── README.md
```

---

## Skill 分层

| 层次 | 特征 | 示例 | 共享 |
|------|------|------|------|
| **第一层** | 通用，无硬编码 | `xlsx`, `hindsight-memory` | ✅ |
| **第二层** | 需参数化 | `tri-node-redis` | ⚠️ 改造后 |
| **第三层** | 节点专属 | `istoreos-openclash` | ❌ |

---

## 同步方式

**派单时强制同步**：
```bash
cd ~/shared-resources/skills && git pull
```

**定时同步**（可选）：
```bash
*/30 * * * * cd ~/shared-resources/skills && git pull -q
```

---

## 发布流程

1. 本地开发测试 Skill
2. 检查无硬编码路径/IP/凭证
3. 复制到共享目录并推送：
   ```bash
   cp -r ~/.hermes/skills/new-skill ~/shared-resources/skills/skills/
   cd ~/shared-resources/skills && git add . && git commit -m "feat: add new-skill" && git push
   ```
4. 群聊通知：`@TMYhermes_bot ✅ new-skill 已发布`

---

## 各节点 Skill 路径配置

在 Hermes `config.yaml` 中添加：
```yaml
skills:
  paths:
    - ~/skills/                    # 节点专属（优先）
    - ~/shared-resources/skills/   # 共享
```