#!/bin/bash
# MCB开发环境停止脚本

echo "🛑 停止MCB开发环境..."

# 停止并移除容器
docker-compose down

echo "✅ 开发环境已停止"