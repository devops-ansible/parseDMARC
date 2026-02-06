FROM python:latest
LABEL org.opencontainers.image.authors="macwinnie <dev@macwinnie.me>"

ENV WORKDIR="/project"
ENV PARSE_JSON="{}"
ENV AGGREGATE="True"
ENV FORENSIC="True"
ENV IMAP_WATCH="True"
ENV ELC_HOST="http://elasticsearch"
ENV ELC_PORT="9200"
ENV ELC_SSL="False"
ENV NO_ELC="False"
ENV GEOIP_ACCOUNTID=""
ENV GEOIP_LICENSEKEY=""
ENV GEOIP_EDITIONIDS=""
ENV GEOIP_INSTALL="/usr/local/bin/geoipupdate"
ENV GEOIP_CONF_FILE="/usr/local/etc/GeoIP.conf"

COPY "script/"  "${WORKDIR}"
COPY "install/" "/install"

WORKDIR "${WORKDIR}"

RUN chmod a+x /install/install.sh && \
    /install/install.sh

ENTRYPOINT [ "entrypoint" ]
CMD [ "parsedmarc", "-c", "/config/parsedmarc.ini" ]
