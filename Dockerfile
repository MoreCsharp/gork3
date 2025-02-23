# 使用官方的 Node.js 镜像作为基础镜像
# 你可以根据你的项目需要选择特定版本，例如：node:14, node:16-alpine, 等
FROM node:18

# 设置工作目录 (容器内的路径)
WORKDIR /app

# 复制 package.json 和 package-lock.json (如果存在)
# 这样可以利用 Docker 的缓存机制，只有在这些文件改变时才重新安装依赖
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 安装 Playwright 和 Chromium
RUN npm install playwright

# 使用 npx playwright install-deps 安装依赖
RUN npx playwright install-deps

RUN npx playwright install chromium

# 复制项目的所有文件到工作目录
COPY . .

# 暴露端口 (如果你的 server.js 监听了特定端口，例如 3000)
EXPOSE 3333

# 定义容器启动时执行的命令
CMD [ "node", "server.js" ]
