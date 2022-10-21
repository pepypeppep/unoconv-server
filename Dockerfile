FROM ubuntu:22.04
# install node js
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_16.x |  bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

## install ms font
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    ttf-mscorefonts-installer \
    git \
    ttf-wqy-zenhei \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-indic \
    fonts-liberation \
    && fc-cache -f -v \
    && rm -rf /var/lib/apt/lists/*



## install unoconv
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:libreoffice/ppa \
    && DEBIAN_FRONTEND=noninteractive apt -y install libreoffice --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    unoconv \
    && rm -rf /var/lib/apt/lists/*

## install python 3.9
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && add-apt-repository ppa:deadsnakes/ppa \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9 \
    && rm -rf /var/lib/apt/lists/*

## set python 3.9 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    &&  update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2 \
    &&  update-alternatives --set python3 /usr/bin/python3.9



WORKDIR /app

COPY . .

ENV HOSTNAME 0.0.0.0
ENV PORT 4000

RUN npm install

EXPOSE 4000

ENTRYPOINT ["./unoconv-server"]
