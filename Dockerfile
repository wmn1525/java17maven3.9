# 使用官方的 OpenJDK 17 作为基础镜像
FROM openjdk:17-jdk-slim

# 设置维护者信息（可选）
LABEL maintainer="your-email@example.com"

# 设置环境变量
ENV MAVEN_VERSION=3.9.0 \
    MAVEN_HOME=/usr/share/maven \
    MAVEN_CONFIG=/root/.m2

# 安装必要的工具和依赖
RUN apt-get update && \
    apt-get install -y curl tar && \
    rm -rf /var/lib/apt/lists/*

# 下载并安装 Maven 3.9
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -o /tmp/apache-maven.tar.gz && \
    mkdir -p /usr/share/maven && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    rm -rf /tmp/apache-maven.tar.gz

# 验证 Maven 安装
RUN mvn -version

# 设置工作目录
WORKDIR /app

# 默认的命令
CMD ["mvn", "--version"]
