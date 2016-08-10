FROM foodresearch/bppc
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>

USER root

# install pre-requisites
RUN  apt-get update && apt-get install -y python-dev python-pip freetype* libfreetype6-dev libpng12-dev pkg-config default-jdk ant r-base
RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN python --version
# installl base qiime
RUN pip install --upgrade pip  && pip install numpy && pip install qiime

# test base qiime
RUN print_qiime_config.py -t
#
RUN git clone https://github.com/qiime/qiime-deploy.git
RUN git clone https://github.com/qiime/qiime-deploy-conf.git
RUN cp qiime-deploy-conf/qiime-1.9.1/qiime.conf qiime-deploy/qiime.conf
RUN mkdir /qiime
RUN python qiime-deploy/qiime-deploy.py /qiime -f qiime-deploy/qiime.conf
# RUN cd qiime-dploy && qiime-deploy.py
ADD Welcome.txt /etc/motd

#RUN $SIAB_COMM
ENTRYPOINT ["/scripts/launchsiab.sh"]
CMD ["/bin/bash"]
