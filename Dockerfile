FROM node:16.17-bullseye-slim

# Installs git, unoconv and microsoft + chinese fonts
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN apt-get update && apt-get -y install \
    git \
    unoconv \
    ttf-wqy-zenhei \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-indic \
    ttf-mscorefonts-installer \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

ENV HOSTNAME 0.0.0.0
ENV PORT 4000

RUN yarn && yarn cache clean

EXPOSE 4000

CMD ["start"]

ENTRYPOINT /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002
ENTRYPOINT ["./unoconv-server"]
