FROM debian

ARG KKMSERVER_VERSION=2.2.15.28_14.09.2022
ARG KKMSERVER_STUFF=KkmServer_$KKMSERVER_VERSION.deb

ADD container/ /
ADD https://github.com/kevinblo/kkmserver_dist/raw/main/deb/$KKMSERVER_STUFF /

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       ca-certificates \
       libc6-dev \
       libcurl4 \
       libgdiplus \
       libicu67 \
       liblttng-ust0 \
       libssl1.1 \
       netcat `# For health checks` \
       openssl \
  && dpkg --install $KKMSERVER_STUFF \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm --force $KKMSERVER_STUFF

ENV LANG ru_RU.utf8

CMD ["/opt/kkmserver/kkmserver", "-s"]

