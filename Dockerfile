FROM continuumio/miniconda3:4.7.10

LABEL name="LIGO Base - Miniconda"
LABEL maintainer="Duncan Macleod <duncan.macleod@ligo.org>"
LABEL support="Best Effort"

RUN /opt/conda/bin/conda config --system --prepend channels conda-forge
