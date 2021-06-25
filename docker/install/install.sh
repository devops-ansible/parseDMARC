#!/usr/bin/env bash

apt-get -y update
apt-get -y install --no-install-recommends \
                apt-utils
apt-get -y upgrade
apt-get -y install \
                jq \
                software-properties-common

pip install --upgrade pip

geoipupdate_release="https://github.com/maxmind/geoipupdate/releases/latest"
geoipdb_dir="/usr/local/share/GeoIP"

geoipupdate_url=$( curl -Ls -o /dev/null -w %{url_effective} ${geoipupdate_release} )
geoipupdate_tgz=$( curl ${geoipupdate_url} | sed -E 's/.*href="(.*?linux_amd64\.tar\.gz).*/\1/g;t;d' )
geoipupdate_dl="$( echo ${geoipupdate_url} | sed -E 's/(.*?:\/\/[^\/]+).*/\1/g;t;d' )/"
geoipupdate_dl="${geoipupdate_dl}$( echo ${geoipupdate_tgz} | sed -E 's/(.*?:\/\/[^\/]+)?\/(.*)/\2/g;t;d' )"

curl -Lo geoipupdate.tgz ${geoipupdate_dl}
mkdir "${GEOIP_INSTALL}" "${geoipdb_dir}"
tar xfz geoipupdate.tgz --strip-components=1 -C "${GEOIP_INSTALL}"

apt-get autoremove
apt-get autoclean
apt-get clean
rm -rf /var/lib/apt/lists/*

cd ${WORKDIR}
pip install -r requirements.txt

mv /install/entrypoint.sh /usr/local/bin/entrypoint
chmod a+x /usr/local/bin/entrypoint

mkdir /config /templates
mv /install/*.j2 /templates/

rm -rf /install
