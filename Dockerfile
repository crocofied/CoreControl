FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y git make gcc && \
    git clone https://github.com/crocofied/CoreControl.git /corecontrol && \
    make -C /corecontrol && \
    mv /corecontrol/corecontrol /usr/bin/corecontrol && \
    rm -rf /corecontrol && \
    apt-get remove -y git make gcc && \
    apt-get autoremove -y && \
    apt-get clean

ENTRYPOINT ["corecontrol"]
CMD ["status"]
