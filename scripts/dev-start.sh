#!/bin/bash
# MCB开发环境启动脚本

echo "🚀 启动MCB开发环境..."

# 检查.env文件
if [ ! -f .env ]; then
    echo "📝 创建.env文件 (从.env.example复制)"
    cp .env.example .env
    echo "⚠️  请检查.env文件并根据需要修改配置"
fi

# 启动服务（包含pgAdmin）
echo "🐳 启动Docker服务..."
docker-compose --profile dev up -d

# 等待服务启动
echo "⏳ 等待服务启动..."
sleep 10

# 显示服务状态
echo "📊 服务状态："
docker-compose ps

echo ""
echo "✅ 开发环境启动完成!"
echo "🌐 服务访问地址："
echo "  - 后端API: http://localhost:8080"
echo "  - 数据库: localhost:5432"
echo "  - pgAdmin: http://localhost:5050 (admin@mcb.com / admin)"
echo ""
echo "📝 常用命令："
echo "  - 查看日志: docker-compose logs -f backend"
echo "  - 停止服务: docker-compose down"
echo "  - 重启后端: docker-compose restart backend"