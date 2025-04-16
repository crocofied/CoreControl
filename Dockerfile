FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        make \
        gcc \
        build-essential \
        curl && \
    git clone https://github.com/crocofied/CoreControl.git /corecontrol && \
    make -C /corecontrol && \
    mv /corecontrol/corecontrol /usr/bin/corecontrol && \
    rm -rf /corecontrol && \
    apt-get remove -y git make gcc build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["corecontrol"]
CMD ["status"]
