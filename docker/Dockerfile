FROM python:latest
MAINTAINER macwinnie <dev@macwinnie.me>

ENV WORKDIR="/project"
ENV PARSE_JSON="{}"
ENV AGGREGATE="True"
ENV FORENSIC="True"
ENV IMAP_WATCH="True"
ENV ELC_HOST="http://elasticsearch"
ENV ELC_PORT="9200"
ENV ELC_SSL="False"
ENV NO_ELC="False"

COPY "script/"  "${WORKDIR}"
COPY "install/" "/install"

WORKDIR "${WORKDIR}"

RUN chmod a+x /install/install.sh && \
    /install/install.sh

ENTRYPOINT [ "entrypoint" ]
CMD [ "parsedmarc", "-c", "/config/parsedmarc.ini" ]
