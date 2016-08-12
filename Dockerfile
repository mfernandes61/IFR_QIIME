FROM foodresearch/bppc
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>

USER root

RUN add-apt-repository  "deb http://archive.ubuntu.com/ubuntu xenial main universe"
RUN add-apt-repository -y ppa:j-4/vienna-rna
# install pre-requisites
RUN  apt-get update && apt-get install -y python-dev python-pip freetype* libfreetype6-dev libpng12-dev pkg-config default-jdk ant r-base  r-base-dev libgsl-dev perl seqprep ampliconnoise gfortran unzip
RUN apt-get update && apt-get install -y libssl-dev libzmq-dev libxml2 libxslt1.1 libxslt1-dev subversion sqlite3 libsqlite3-dev
RUN apt-get update && apt-get install -y mpich2 libreadline-dev libmysqlclient18 libmysqlclient-dev ghc libc6-i386 libbz2-dev tcl-dev tk-dev libatlas-dev libatlas-base-dev liblapack-dev swig libhdf5-serial-dev
RUN apt-get update && apt-get install -y ampliconnoise bwa vienna-rna cd-hit
RUN apt-get update && apt-get install -y fasttree infernal chimeraslayer rtax muscle mothur
RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# installl base qiime
RUN pip install --upgrade pip  && pip install numpy && pip install qiime

# test base qiime
RUN print_qiime_config.py -t
#
RUN git clone https://github.com/qiime/qiime-deploy.git
RUN git clone https://github.com/qiime/qiime-deploy-conf.git
ADD qiime.conf qiime-deploy/qiime.conf
# RUN cp qiime-deploy-conf/qiime-1.9.1/qiime.conf qiime-deploy/qiime.conf
RUN mkdir /qiime
RUN python qiime-deploy/qiime-deploy.py /qiime -f qiime-deploy/qiime.conf
# RUN cd qiime-dploy && qiime-deploy.py
ADD Welcome.txt /etc/motd

#RUN $SIAB_COMM
ENTRYPOINT ["/scripts/launchsiab.sh"]
CMD ["/bin/bash"]
