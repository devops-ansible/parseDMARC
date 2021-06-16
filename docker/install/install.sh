#!/usr/bin/env bash

apt-get -y update
apt-get -y install --no-install-recommends \
                apt-utils
apt-get -y upgrade
apt-get -y install \
                jq \
                software-properties-common
add-apt-repository ppa:maxmind/ppa
apt-get -y update
apt-get -y install \
                geoipupdate

pip install --upgrade pip

apt-get autoremove
apt-get autoclean
apt-get clean
rm -rf /var/lib/apt/lists/*

cd ${WORKDIR}
pip install -r requirements.txt

mv /install/entrypoint.sh /usr/local/bin/entrypoint
chmod a+x /usr/local/bin/entrypoint

mkdir /config
mv /install/parsedmarc.ini.j2 /config/parsedmarc.ini.j2

rm -rf /install
