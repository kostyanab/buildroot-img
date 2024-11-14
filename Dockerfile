FROM debian:bookworm-slim

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone;

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get -y install \
    debianutils \ 
    sed \ 
    make \ 
    binutils \ 
    build-essential \ 
    gcc \ 
    g++ \  
    bash \ 
    patch \ 
    gzip \ 
    bzip2 \ 
    perl \ 
    tar \ 
    cpio \ 
    unzip \ 
    rsync \ 
    file \ 
    bc \ 
    git \ 
    findutils \
    diffutils \
    wget \
    python3 \
    locales-all \
    locales \
    libgnutls28-dev \
    expect && \
    apt-get -y autoremove && \
    apt-get clean && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US:en && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

    RUN locale-gen en_US.UTF-8 ru_RU.UTF-8 && \
        useradd -ms /bin/bash user && \
        usermod -aG sudo user && \
        echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

USER user
CMD /bin/bash
WORKDIR /home/user
