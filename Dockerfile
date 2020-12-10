FROM centos:8

LABEL name="LIGO Base - Enterprise Linux 8" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      support="Best Effort"

# enable extra repositories
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && \
    dnf -y install http://software.ligo.org/lscsoft/centos/8/production/x86_64/os/l/lscsoft-production-config-8-4.el8.noarch.rpm && \
    dnf -y install 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled PowerTools && \
    dnf clean all

# add osg repository
RUN echo "[osg]" > /etc/yum.repos.d/osg.repo && \
    echo "name=OSG Software for Enterprise Linux 8 - \$basearch" >> /etc/yum.repos.d/osg.repo && \
    echo "baseurl=https://repo.opensciencegrid.org/osg/3.5/el8/release/\$basearch" >> /etc/yum.repos.d/osg.repo && \
    echo "failovermethod=priority" >> /etc/yum.repos.d/osg.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/osg.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/osg.repo && \
    echo "gpgkey=http://repo.opensciencegrid.org/osg/RPM-GPG-KEY-OSG" >> /etc/yum.repos.d/osg.repo && \
    echo "exclude=*condor*" >> /etc/yum.repos.d/osg.repo

# install extra packages
RUN dnf -y install \
      bash-completion \
      epel-release \
      lscsoft-production-debug-config && \
    dnf clean all

# install available updates
RUN dnf -y update && dnf clean all
