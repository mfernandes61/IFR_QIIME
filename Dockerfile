FROM foodresearch/bbpc
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>

USER root

# install pre-requisites

RUN  apt-get update && apt-get install -y python-dev python-pip
RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# installl base qiime
RUN pip install numpy qiime

# test base qiime
print_qqime_config.py -t
#
ADD Welcome.txt /etc/motd

#RUN $SIAB_COMM
ENTRYPOINT ["/scripts/launchsiab.sh"]
CMD ["/bin/bash"]
