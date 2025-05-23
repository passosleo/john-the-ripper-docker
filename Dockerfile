FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libssl-dev \
    yasm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/openwall/john.git /opt/john && \
    cd /opt/john/src && \
    ./configure && \
    make -s clean && \
    make -sj$(nproc)

RUN curl -L -o /rockyou.txt https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

WORKDIR /data

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/data/entrypoint.sh"]
