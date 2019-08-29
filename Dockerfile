FROM continuumio/miniconda3:4.7.10-alpine

LABEL name="LIGO Base - Miniconda" \
      maintainer="Duncan Macleod <duncan.macleod@ligo.org>" \
      support="Best Effort"

RUN /opt/conda/bin/conda config --system --prepend channels conda-forge && \
    /opt/conda/bin/conda config --system --append channels lscsoft
