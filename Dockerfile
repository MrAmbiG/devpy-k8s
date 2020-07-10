FROM python:3.7-buster

ENV DEVPI_ROOT_PASSWORD=root \
    DEVPISERVER_SERVERDIR="/data/server" \
    DEVPI_CLIENTDIR="/data/client" \
    DEVPI_USER=devpie \
    DEVPI_PASSWORD=devpie \

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install vim -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD src /
EXPOSE 3141
RUN python3.7 -m ensurepip && python3.7 -m pip install --no-cache-dir -r /requirements.txt && mkdir -p "${DEVPISERVER_SERVERDIR}" && mkdir -p "${DEVPI_CLIENTDIR}" && cp entrypoint.sh /usr/local/bin/ && chmod +x /usr/local/bin/entrypoint.sh

# Keep the docker running in kubernetes
ENTRYPOINT ["entrypoint.sh"]
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
