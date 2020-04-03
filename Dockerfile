FROM centos:8

LABEL name="LIGO Base - Enterprise Linux 8 - Testing" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      support="Best Effort"

# enable extra repositories
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && \
    dnf -y install http://software.ligo.org/lscsoft/centos/8/production/x86_64/os/l/lscsoft-production-config-8-4.el8.noarch.rpm && \
    dnf -y install 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled PowerTools && \
    dnf clean all

# install extra packages
RUN dnf -y install \
      bash-completion \
      epel-release \
      lscsoft-production-debug-config \
      lscsoft-testing-config \
      lscsoft-testing-debug-config && \
    dnf clean all

# install available updates
RUN dnf -y update && dnf clean all
