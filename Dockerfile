# from template debian 
FROM renzok/debian:latest

MAINTAINER Renzo Kottmann <renzo.kottmann@gmail.com>

# Based on original image (see https://github.com/rocker-org/shiny/blob/master/Dockerfile)
# Criticism of original:
# 1. missing rm of  /var/lib/apt/lists apt-get cache and /tmp
# 2. and no explicit versioning (version pinning in debian slang)
# 3. runs as root by default
 
ENV APP_DIR=/opt/shiny-server \
    SHINY_VERSION=1.5.2.837 \
    SHINY_USER=shiny \
    CRAN_MIRROR='http://cloud.r-project.org'

RUN echo "deb ${CRAN_MIRROR}/bin/linux/debian jessie-cran3/" >> /etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get install --no-install-recommends --auto-remove --force-yes -y  \
      r-base=3.3.2* \
      build-essential \
      lsb-release=4.1+Debian13*
   
# COPY ss-latest.deb .

RUN curl "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-${SHINY_VERSION}-amd64.deb" -o ss-latest.deb && \
    dpkg --install ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='${CRAN_MIRROR}')" && \
    chown shiny:shiny /var/lib/shiny-server && \ 
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    rm -rf /var/lib/apt/lists/* ss-latest.deb /tmp/* 

EXPOSE 3838

USER ${SHINY_USER}

ENTRYPOINT ["shiny-server"]
