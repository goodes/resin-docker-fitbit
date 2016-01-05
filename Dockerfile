# fitbit galileo
# a docker image to sunc fitbit devices
# VERSION       1.0
FROM resin/rpi-raspbian:jessie

RUN touch /tmp/a

# install all packages needed by galileo (may be redundant but done in case the base image is 
# changed)
RUN apt-get update && \
    apt-get install -y libusb-1.0-0 ncftp ftp rsync ntp python python-pip python-requests && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y vim net-tools less openssl shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN pip install 'pyusb==1.0.0b1' galileo && mkdir -p /etc/galileo
RUN pip install 'pyusb==1.0.0b1' https://bitbucket.org/goodes/galileo/get/tip.tar.gz && mkdir -p /etc/galileo

COPY shellinabox /etc/default/shellinabox
COPY galileorc /etc/galileo/config
COPY start_galileo.sh /start_galileo.sh
RUN chmod 755 /start_galileo.sh

#start to daemon to run fitbit sync every 15 minutes (this can be overwritten using 'docker run')
CMD ["/start_galileo.sh"]
#CMD ["/bin/bash"]
