FROM anapsix/alpine-java:8u192b12_jdk
ENV version=2.0.2
ENV KE_HOME=/kafka-eagle
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update && apk add curl && apk add sqlite && apk add tar

##将本地文件复制到docker中
COPY kafka-eagle-bin-2.0.3.tar.gz .

#RUN curl -OL "https://github.com/smartloli/kafka-eagle-bin/archive/v2.0.3.tar.gz" && \
RUN     tar -xzvf kafka-eagle-bin-2.0.3.tar.gz && \
        tar -xzvf kafka-eagle-bin-2.0.3/kafka-eagle-web-2.0.3-bin.tar.gz && \
        mv kafka-eagle-web-2.0.3 /kafka-eagle && \
        rm -rf kafka-eagle-bin-2.0.3.tar.gz kafka-eagle-bin-2.0.3
WORKDIR /kafka-eagle
COPY system-config.properties ./conf/system-config.properties
COPY entrypoint.sh ./bin/entrypoint.sh
CMD ["sh", "/kafka-eagle/bin/entrypoint.sh"]