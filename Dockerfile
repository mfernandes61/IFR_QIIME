FROM foodresearch/bppc
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>

USER root

# install pre-requisites
RUN  apt-get update && apt-get install -y python-dev python-pip freetype* libfreetype6-dev libpng12-dev pkg-config
RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN python --version
# installl base qiime
RUN pip install --upgrade pip  && pip install numpy && pip install qiime

# test base qiime
RUN print_qiime_config.py -t
#
ADD Welcome.txt /etc/motd

#RUN $SIAB_COMM
ENTRYPOINT ["/scripts/launchsiab.sh"]
CMD ["/bin/bash"]
