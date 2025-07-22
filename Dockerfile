# Базовый образ
FROM debian:bookworm-slim

# Параметры
ARG TZ=Europe/Moscow
ENV TZ=${TZ} \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

# Установка нужных пакетов, timezone и локали
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      tzdata \
      locales-all \
      sudo \
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
 && rm -rf /var/lib/apt/lists/* \
 \
 # Запись переменных локали
 && { \
      echo "LANG=${LANG}"; \
      echo "LC_ALL=${LC_ALL}"; \
      echo "LANGUAGE=${LANGUAGE}"; \
    } > /etc/default/locale

# Создаём пользователя и настраиваем sudo без пароля
RUN useradd -m -s /bin/bash user \
 && usermod -aG sudo user \
 && echo 'user ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/90-user \
 && chmod 440 /etc/sudoers.d/90-user

# Переключаемся на непривилегированного пользователя
USER user
WORKDIR /home/user

# Точка входа
CMD ["bash"]
