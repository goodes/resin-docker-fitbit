# fitbit galileo
# a docker image to sunc fitbit devices
# VERSION       1.0
FROM resin/rpi-raspbian:jessie

RUN touch /tmp/b

# install all packages needed by galileo (may be redundant but done in case the base image is 
# changed)
RUN apt-get update && \
    apt-get install -y libusb-1.0-0 netcat ncftp ftp rsync curl wget ntpdate python python-pip python-requests && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y vim net-tools less openssl shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN pip install 'pyusb==1.0.0b1' galileo && mkdir -p /etc/galileo
RUN touch /tmp/b
RUN pip install certifi 'pyusb==1.0.0b1' https://bitbucket.org/benallard/galileo/get/tip.tar.gz && mkdir -p /etc/galileo
#RUN pip install 'pyusb==1.0.0b1' https://bitbucket.org/benallard/galileo/get/0.4.4.tar.gz && mkdir -p /etc/galileo

RUN mv /etc/localtime /etc/localtime_old && ln -s /usr/share/zoneinfo/Israel /etc/localtime    

COPY shellinabox /etc/default/shellinabox
COPY galileorc /etc/galileo/config
COPY start_galileo.sh /start_galileo.sh
COPY update_date /update_date
COPY update_time.py /update_time.py
COPY checktime.py /checktime.py
COPY periodic_backup.sh /periodic_backup.sh

RUN chmod 755 /start_galileo.sh && chmod 755 /update_date && chmod 755 /checktime.py && chmod 755 /periodic_backup.sh && chmod 755 /update_time.py

#COPY mitmproxy-ca-cert.pem /mitmproxy-ca-cert.pem
#RUN cat /mitmproxy-ca-cert.pem >> /usr/local/lib/python2.7/dist-packages/certifi/cacert.pem                                                                               
RUN sed -i "s/(5000)/(15000)/g" /usr/local/lib/python2.7/dist-packages/galileo/tracker.py  

#start to daemon to run fitbit sync every 15 minutes (this can be overwritten using 'docker run')
CMD ["/start_galileo.sh"]
#CMD ["/bin/bash"]
