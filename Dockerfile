FROM node:16.17-bullseye-slim

# Installs git, unoconv and microsoft + chinese fonts
RUN echo "deb http://deb.debian.org/debian/ bullseye contrib non-free" >> /etc/apt/sources.list
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    git \
    unoconv \
    ttf-wqy-zenhei \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-indic \
    ttf-mscorefonts-installer \
    fonts-liberation \
    && fc-cache -f -v \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

ENV HOSTNAME 0.0.0.0
ENV PORT 4000

RUN yarn && yarn cache clean

EXPOSE 4000

ENTRYPOINT ["./unoconv-server"]
