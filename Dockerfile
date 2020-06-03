FROM rocker/shiny

# Adaptation of rocker/shiny
# https://hub.docker.com/r/rocker/shiny/dockerfile

# RUN apt-get update && apt-get install -y \
#     gdebi-core \
#     pandoc \
#     pandoc-citeproc \
#         xtail

# Download and install shiny server
RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment && \
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='$MRAN')" && \
    chown shiny:shiny /var/lib/shiny-server && \
    sudo usermod -a -G staff shiny

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

RUN mkdir /home/shiny/.ssh && \
    chown shiny /home/shiny/.ssh
COPY .ssh/* /home/shiny/.ssh

RUN mkdir /home/shiny/apps && \
    git clone /home/daslu/r-playground/ /home/shiny/apps

RUN rm * /srv/shiny-server/*
RUN cp -r /home/shiny/apps /srv/shiny-server/ && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

CMD ["shiny-server"]
