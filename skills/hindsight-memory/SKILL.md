---
name: hindsight-memory
description: Hindsight 三节点共享记忆库操作技能。触发词：记忆、记忆库、hindsight、shared memory
tags:
  - memory
  - hindsight
  - tri-node
---

# Hindsight 记忆库操作

> **触发条件**：需要操作三节点共享记忆库时加载此 Skill

---

## 一、系统信息

| 项目 | 值 |
|------|-----|
| API 地址 | `http://jevis.taila7698a.ts.net:8888` |
| UI 地址 | `http://jevis.taila7698a.ts.net:9999` |
| 记忆库 ID | `trinode-shared` |
| 数据库位置 | 奥创 PostgreSQL (端口 5432) |

---

## 二、API 操作

### 2.1 写入记忆

```bash
curl -X POST "http://jevis.taila7698a.ts.net:8888/v1/default/banks/trinode-shared/retain" \
  -H "Content-Type: application/json" \
  -d '{
    "facts": [
      {
        "text": "记忆内容",
        "fact_type": "experience",
        "tags": ["标签1", "标签2"],
        "context": "上下文说明"
      }
    ]
  }'
```

**fact_type 类型**：
- `experience`: 经验/操作记录
- `world`: 客观事实
- `observation`: 观察/总结

### 2.2 搜索记忆

```bash
curl -X POST "http://jevis.taila7698a.ts.net:8888/v1/default/banks/trinode-shared/recall" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "搜索关键词",
    "limit": 10
  }'
```

### 2.3 获取记忆库信息

```bash
curl "http://jevis.taila7698a.ts.net:8888/v1/default/banks/trinode-shared"
```

### 2.4 列出所有记忆

```bash
curl "http://jevis.taila7698a.ts.net:8888/v1/default/banks/trinode-shared/memories?limit=100"
```

---

## 三、Python 集成示例

```python
import urllib.request
import json

HINDSIGHT_URL = "http://jevis.taila7698a.ts.net:8888"
BANK_ID = "trinode-shared"

def write_memory(text, fact_type="experience", tags=None, context=None):
    """写入记忆到 Hindsight"""
    data = {
        "facts": [{
            "text": text,
            "fact_type": fact_type,
            "tags": tags or [],
            "context": context
        }]
    }
    url = f"{HINDSIGHT_URL}/v1/default/banks/{BANK_ID}/retain"
    req = urllib.request.Request(url, data=json.dumps(data).encode(), method="POST")
    req.add_header("Content-Type", "application/json")
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.loads(resp.read().decode())

def search_memory(query, limit=10):
    """搜索记忆"""
    data = {"query": query, "limit": limit}
    url = f"{HINDSIGHT_URL}/v1/default/banks/{BANK_ID}/recall"
    req = urllib.request.Request(url, data=json.dumps(data).encode(), method="POST")
    req.add_header("Content-Type", "application/json")
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.loads(resp.read().decode())
```

---

## 四、使用场景

1. **任务完成后写记忆**：将关键信息存入共享记忆库
2. **跨会话查询**：搜索历史记忆获取上下文
3. **节点协作**：三节点共享同一记忆库，互通信息

---

## 五、注意事项

- API 无需认证（当前配置）
- 所有节点通过 Tailscale 网络访问
- 数据库在奥创，确保 Mac 不休眠