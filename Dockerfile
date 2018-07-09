FROM armhfbuild/debian:wheezy
LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <https://twitter.com/MoulinJay>"


RUN mkdir -p /opt/JDownloader/ && \
    apt-get update  && \
    apt-get install openjdk-7-jre-headless procps -y --no-install-recommends  && \
    wget -O /opt/JDownloader/JDownloader.jar "http://installer.jdownloader.org/JDownloader.jar?$RANDOM" && \
    chmod +x /opt/JDownloader/JDownloader.jar && \
    wget -O /usr/bin/tini "https://github.com/krallin/tini/releases/download/v0.18.0/tini-armhf" --no-check-certificate && \
    chmod +x /usr/bin/tini && \
    wget -O "/opt/JDownloader/daemon.sh" "https://raw.githubusercontent.com/well0nez/docker-jdownloader/master/daemon.sh" --no-check-certificate  && \
    wget -O "/usr/bin/configure" "https://raw.githubusercontent.com/well0nez/docker-jdownloader/master/configure.sh" --no-check-certificate && \
    wget -O "/opt/JDownloader/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json.dist" "https://raw.githubusercontent.com/well0nez/docker-jdownloader/master/default-config.json.dist" --no-check-certificate && \  
    chmod +x /usr/bin/configure && \
    chmod +x /opt/JDownloader/daemon.sh
    
VOLUME /root/Downloads
WORKDIR /opt/JDownloader

CMD ["tini", "--", "/opt/JDownloader/daemon.sh"]
