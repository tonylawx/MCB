# MCB Backend Dockerfile
# 使用多阶段构建优化镜像大小

# 阶段1：构建阶段 (Build Stage)
FROM maven:3.9.5-eclipse-temurin-21 AS builder

LABEL stage=mcb-backend-builder

# 设置工作目录
WORKDIR /app

# 复制Maven配置文件（利用Docker层缓存）
COPY pom.xml .

# 下载依赖（这一层会被缓存，除非pom.xml改变）
RUN mvn dependency:go-offline -B

# 复制源代码
COPY src ./src

# 构建应用（跳过测试以加快构建速度，生产环境建议开启测试）
RUN mvn clean package -DskipTests -B

# 阶段2：运行阶段 (Runtime Stage)
FROM eclipse-temurin:21-jre-alpine AS runtime

LABEL maintainer="MCB Team"
LABEL version="0.1.0"
LABEL description="MCB Backend API Server"

# 安装必要的工具
RUN apk add --no-cache \
    curl \
    tzdata

# 设置时区（可根据需要调整）
ENV TZ=Asia/Shanghai

# 创建应用用户（安全最佳实践）
RUN addgroup -g 1001 -S mcb && \
    adduser -u 1001 -S mcb -G mcb

# 设置工作目录
WORKDIR /app

# 从构建阶段复制JAR文件
COPY --from=builder /app/target/*.jar app.jar

# 创建日志目录
RUN mkdir -p /app/logs && \
    chown -R mcb:mcb /app

# 切换到应用用户
USER mcb

# 暴露端口
EXPOSE 8080

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# JVM优化参数
ENV JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC -XX:G1HeapRegionSize=16m -XX:+UseStringDeduplication"

# 启动命令
ENTRYPOINT exec java $JAVA_OPTS -jar app.jar

# 元数据标签
LABEL org.opencontainers.image.title="MCB Backend"
LABEL org.opencontainers.image.description="Multi-Currency Book Backend API"
LABEL org.opencontainers.image.version="0.1.0"