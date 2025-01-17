FROM nvidia/cuda:11.6.2-base-ubuntu20.04

ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

ENV WALLET=0xE7e7eAeA601CfBcBDac6fB3D14D367181F447f06.zil1ryau8mnx43dcsn504cqlypz5y2dnryq8707fcz
ENV SERVER=stratum+tcp://asia.ezil.me:5555
ENV WORKER=Rig
ENV ALGO=ethash
ENV PASS=x
ENV API_PASSWORD=Password1
ENV EXTRA_PARAM=


ENV TREX_URL="https://github.com/trexminer/T-Rex/releases/latest/download/"

ADD config/config.json /home/nobody/

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl libnvidia-ml-dev \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /trex \
    && file_name=$(curl -L  https://github.com/trexminer/T-Rex/releases/latest|grep -io "t-rex-.*-linux.tar.gz"| head -1) \
    && wget --no-check-certificate "${TREX_URL}${file_name}" \
    && tar -xvf ./*.tar.gz  -C /trex \
    && rm *.tar.gz

WORKDIR /trex

ADD init.sh /trex/

VOLUME ["/config"]

CMD ["/bin/bash", "init.sh"]
