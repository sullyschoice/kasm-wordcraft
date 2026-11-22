# Kasm base image tag. Images built on 1.20+ bases do not run on Kasm 1.19 and older.
#   1.19.0-rolling-daily -> Kasm 1.19 and older (default)
#   develop              -> Kasm 1.20 (until a 1.20 rolling base tag is published)
ARG BASE_TAG=1.19.0-rolling-daily

FROM kasmweb/core-ubuntu-noble:${BASE_TAG}
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Leave empty to install the latest release, or pass e.g. --build-arg WORDCRAFT_VERSION=0.6.1
ARG WORDCRAFT_VERSION=""

COPY ./src/wordcraft $INST_SCRIPTS/wordcraft/
RUN WORDCRAFT_VERSION=${WORDCRAFT_VERSION} bash $INST_SCRIPTS/wordcraft/install_wordcraft.sh && rm -rf $INST_SCRIPTS/wordcraft/

COPY ./src/wordcraft/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
