# Используем официальный минимальный образ
FROM debian:bookworm-slim

# Параметр для часового пояса
ARG TZ=Europe/Moscow

# Окружение
ENV TZ=${TZ} \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

# Установка пакетов и настройка
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      tzdata \
      locales-all \
      ca-certificates \
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
      libgnutls28-dev \
      expect \
 && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
 && dpkg-reconfigure -f noninteractive tzdata \
 && update-locale LANG=${LANG} LC_ALL=${LC_ALL} LANGUAGE=${LANGUAGE} \
 && rm -rf /var/lib/apt/lists/*

# Создаём пользователя, sudo без пароля
RUN useradd -m -s /bin/bash user \
 && adduser user sudo \
 && echo 'user ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/90-user \
 && chmod 440 /etc/sudoers.d/90-user

# Переход на непривилегированного пользователя
USER user
WORKDIR /home/user

# Точка входа
CMD ["bash"]
