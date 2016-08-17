FROM foodresearch/bppc
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>

USER root

RUN add-apt-repository  "deb http://archive.ubuntu.com/ubuntu xenial main universe"
RUN add-apt-repository -y ppa:j-4/vienna-rna
# install pre-requisites
RUN  apt-get update && apt-get install -y python-dev python-pip freetype* libfreetype6-dev libpng12-dev pkg-config default-jdk \
 ant r-base  r-base-dev libgsl-dev perl seqprep ampliconnoise gfortran unzip libssl-dev libzmq-dev libxml2 libxslt1.1 libxslt1-dev \
 subversion sqlite3 libsqlite3-dev mpich2 libreadline-dev libmysqlclient18 libmysqlclient-dev ghc libc6-i386 libbz2-dev tcl-dev \
 tk-dev libatlas-dev libatlas-base-dev liblapack-dev swig libhdf5-serial-dev ampliconnoise bwa vienna-rna cd-hit clearcut raxml \
  fasttree infernal chimeraslayer rtax muscle mothur
RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# RUN ln -s  /usr/bin/ChimeraSlayer /usr/lib/ChimeraSlayer.pl && ln -s  /usr/lib/cd-hit/cd-hit /usr/bin/cd-hit
# installl base qiime & python pre-reqs
RUN pip install --upgrade pip  && pip install numpy && pip install h5py && pip install qiime

RUN wget https://github.com/danknights/sourcetracker/archive/v1.0.1.tar.gz
# test base qiime
RUN print_qiime_config.py -t
#
RUN git clone https://github.com/ibest/clearcut.git
RUN git clone https://github.com/qiime/qiime-deploy.git
RUN git clone https://github.com/qiime/qiime-deploy-conf.git
ADD qiime.conf qiime-deploy/qiime.conf
ADD usearch6.1.544_i86linux32 /usr/bin/usearch
# RUN cp qiime-deploy-conf/qiime-1.9.1/qiime.conf qiime-deploy/qiime.conf
RUN mkdir /qiime
RUN python qiime-deploy/qiime-deploy.py /qiime -f qiime-deploy/qiime.conf
# RUN cd qiime-dploy && qiime-deploy.py
ADD Welcome.txt /etc/motd

#Inherited from bppc Volumes /etc/shellinabox,/home, /var/log/supervisor. Ports22, 4200 Need temp writeable dir for qiime tests
#RUN mkdir /usr/tmp
#VOLUME /usr/tmp
#
#RUN $SIAB_COMM
ENTRYPOINT ["/scripts/launchsiab.sh"]
CMD ["/bin/bash"]
