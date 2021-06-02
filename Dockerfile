FROM prom/prometheus

LABEL maintainer="Jeremy Garigliet <jeremy.garigliet@gmail.com>"

ARG USER
ARG GROUP
ARG UID
ARG GID
ENV USER=${USER:-monitor}
ENV GROUP=${GROUP:-monitor}
ENV UID=${UID:-10667}
ENV GID=${GID:-10667}

USER root

RUN addgroup -g ${GID} ${USER} && \
    adduser -g '' -s /bin/false -G ${GROUP} -D -H -u ${GID} ${USER}

RUN mkdir -p /var/prometheus && \
    chown -vR ${UID}:${GID} /etc/prometheus /var/prometheus

USER ${USER}

VOLUME [ "/var/prometheus" ]

WORKDIR /var/prometheus

CMD [ "--config.file=/etc/prometheus/prometheus.yml", \
    "--storage.tsdb.path=/var/prometheus", \
    "--web.console.libraries=/usr/share/prometheus/console_libraries", \
    "--web.console.templates=/usr/share/prometheus/consoles" ]
