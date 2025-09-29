#!/usr/bin/env bash

set -eu -o pipefail

apt-get -y update
apt-get -y install --no-install-recommends \
                apt-utils
apt-get -y upgrade
apt-get -y install \
                jq

pip install --upgrade pip

geoip_github_api="https://api.github.com/repos/maxmind/geoipupdate/releases"
geoip_github_release_id="$( curl "${geoip_github_api}" | jq -r "first( .[] ) | .id" )"
geoip_github_assets_api="${geoip_github_api}/${geoip_github_release_id}/assets"
geoip_github_release_tgz="$( curl "${geoip_github_assets_api}" | jq -r '.[] | select( .name | contains( "linux_amd64.tar.gz" ) ) | .browser_download_url' )"

geoipdb_dir="/usr/local/share/GeoIP"

curl -Lo geoipupdate.tgz ${geoip_github_release_tgz}
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
