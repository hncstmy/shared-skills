#!/bin/bash
# 同步共享技能库
# 用法: ./sync-skills.sh

SKILL_DIR="${HOME}/shared-resources/skills"

if [ -d "$SKILL_DIR" ]; then
    cd "$SKILL_DIR"
    git pull -q origin main
    echo "✅ Skill 同步完成: $(date)"
else
    echo "❌ 目录不存在: $SKILL_DIR"
    echo "   请先 clone: git clone https://github.com/hncstmy/shared-skills.git ~/shared-resources/skills"
fi