FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    gcc \
    make \
    qemu-system-x86 \
    cpio \
    flex \
    wget \
    bison \
    libncurses-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /unikraft

RUN git clone -b RELEASE-0.19.0 https://github.com/unikraft/unikraft.git && \
    mkdir libs && cd libs && \
    git clone -b staging https://github.com/unikraft/lib-nginx.git && \
    git clone -b staging https://github.com/unikraft/lib-mimalloc.git && \
    git clone -b staging https://github.com/unikraft/lib-lwip.git && \
    git clone -b staging https://github.com/unikraft/lib-newlib.git && \
    git clone -b staging https://github.com/unikraft/lib-pthread-embedded.git && \
    ls -l /unikraft/libs/

WORKDIR /unikraft/apps/nginx
COPY Makefile Makefile.uk nginx-mimalloc.conf nginx.cpio ./
RUN mv nginx-mimalloc.conf .config
RUN ln -s /unikraft/unikraft /unikraft/libs/* .

RUN make prepare && make -j$(nproc)

CMD ["cp", "build/nginx_kvm-x86_64", "/host"]
