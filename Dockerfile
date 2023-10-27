FROM debian:bullseye-slim
RUN apt-get update -q && apt-get install -q -y build-essential wget unzip
RUN wget https://github.com/juyeongkim/FATCAT-dist/archive/refs/heads/master.zip && \
  unzip master.zip
WORKDIR /FATCAT-dist-master
RUN ./Install && \
  echo 'export FATCAT=/FATCAT-dist-master' >> /root/.bashrc && \
  echo 'setenv FATCAT /FATCAT-dist-master' >> /root/.cshrc && \
  echo 'export PATH=/FATCAT-dist-master/FATCATMain:$PATH' >> /root/.login
