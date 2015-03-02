FROM registry:0.9.1

RUN apt-get update && \
    apt-get install -y --no-install-recommends redis-server && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ADD run.sh /usr/local/bin/run
CMD ["/usr/local/bin/run"]
