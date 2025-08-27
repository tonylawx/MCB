#!/bin/bash
# 查看MCB服务日志

SERVICE=${1:-backend}

echo "📜 查看 $SERVICE 服务日志..."
echo "按 Ctrl+C 退出"

docker-compose logs -f $SERVICE