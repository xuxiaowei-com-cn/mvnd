ARG DRAGONWELL_VERSION=$DRAGONWELL_VERSION
FROM alibabadragonwell/dragonwell:$DRAGONWELL_VERSION

LABEL maintainer="徐晓伟 <xuxiaowei@xuxiaowei.com.cn>"

ARG CI_PIPELINE_URL=$CI_PIPELINE_URL
ARG MVND_VERSION=$MVND_VERSION
ARG PLATFORM=linux
ARG ARCH=amd64
ARG BASE_URL=https://github.com/apache/maven-mvnd/releases/download/$MVND_VERSION

RUN curl -fsSL -o /tmp/maven-mvnd.tar.gz ${BASE_URL}/maven-mvnd-${MVND_VERSION}-${PLATFORM}-${ARCH}.tar.gz \
    && mkdir -p /usr/share/mvnd \
    && tar --strip-components=1 -xzf /tmp/maven-mvnd.tar.gz -C /usr/share/mvnd \
    && ls /usr/share/mvnd \
    && /usr/share/mvnd/bin/mvnd -v \
    && ln -s /usr/share/mvnd/bin/mvnd /usr/bin/mvnd \
    && mvnd -v \
    && /usr/share/mvnd/mvn/bin/mvn -v \
    && ln -s /usr/share/mvnd/mvn/bin/mvn /usr/bin/mvn \
    && mvn -v \
    && rm -rf /tmp/maven-mvnd.tar.gz
