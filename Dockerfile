FROM debian:bullseye-slim
RUN apt-get update -q && apt-get install -q -y wget unzip
RUN wget https://github.com/GodzikLab/FATCAT-dist/archive/refs/heads/master.zip && \
  unzip master.zip
WORKDIR /FATCAT-dist-master
RUN ./Install && \
  echo 'export FATCAT=/FATCAT-dist-master' >> /root/.bashrc && \
  echo 'export FATCAT=/FATCAT-dist-master' >> /root/.cshrc && \
  echo 'export PATH=/FATCAT-dist-master/FATCATMain:$PATH' >> /root/.login
