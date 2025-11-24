FROM redis:7.2-alpine

# 复制自定义配置文件
#COPY redis.conf /usr/local/etc/redis/redis.conf
COPY docker/redis.conf /usr/local/etc/redis/redis.conf

# 创建数据目录
RUN mkdir -p /data && chown redis:redis /data

# 使用自定义配置启动
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

EXPOSE 6379