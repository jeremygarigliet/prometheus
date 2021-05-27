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

RUN chown -R ${USER}:${USER} /etc/prometheus /prometheus

USER ${USER}
