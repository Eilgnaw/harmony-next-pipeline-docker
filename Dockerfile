# 使用 Ubuntu 20.04 作为基础镜像
FROM ubuntu:20.04

# 设置环境变量以避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具
RUN apt-get update && \
    apt-get install -y \
        wget \
        unzip \
        openjdk-17-jdk \
        git \
        && rm -rf /var/lib/apt/lists/*

# 设置 JDK 17 环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# 下载并安装 HarmonyOS CLI 工具
RUN mkdir -p /opt/harmonyos-tools && \
    wget -q -O /tmp/commandline-tools-linux.zip "https://contentcenter-vali-drcn.dbankcdn.cn/pvt_2/DeveloperAlliance_package_901_9/de/v3/kICkkkAeThGTxoJ0yD55vA/commandline-tools-linux-x64-26.0.0.851.zip?HW-CC-KV=V1&HW-CC-Date=20261010T083715Z&HW-CC-Expire=315360000&HW-CC-Sign=FCDAB44FEE36A32A951F9DD131E566D7F451D3E6160794BF6C3CE88967D17323" && \
    unzip -q /tmp/commandline-tools-linux.zip -d /opt/harmonyos-tools/ && \
    chmod -R +x /opt/harmonyos-tools/command-line-tools/bin && \
    rm /tmp/commandline-tools-linux.zip

# 设置 HarmonyOS CLI 工具的环境变量
ENV COMMANDLINE_TOOL_DIR=/opt/harmonyos-tools
ENV PATH=$COMMANDLINE_TOOL_DIR/command-line-tools/bin:$PATH
ENV HDC_HOME=$COMMANDLINE_TOOL_DIR/command-line-tools/sdk/default/openharmony/toolchains
ENV PATH=$HDC_HOME:$PATH
ENV OHOS_BASE_SDK_HOME=$COMMANDLINE_TOOL_DIR/command-line-tools/sdk/default/openharmony

# 设置工作目录
WORKDIR /workspace

# 设置默认命令
CMD ["bash"]
