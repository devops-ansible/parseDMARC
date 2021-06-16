#!/usr/bin/env bash

set -e

c_aggregate=$(  echo "${PARSE_JSON}" | jq '.general.save_aggregate' )
c_forensic=$(   echo "${PARSE_JSON}" | jq '.general.save_forensic' )

c_imap_host=$(  echo "${PARSE_JSON}" | jq '.imap.host' )
c_imap_user=$(  echo "${PARSE_JSON}" | jq '.imap.user' )
c_imap_pass=$(  echo "${PARSE_JSON}" | jq '.imap.password' )
c_imap_watch=$( echo "${PARSE_JSON}" | jq '.imap.watch' )

c_elc_hosts=$(  echo "${PARSE_JSON}" | jq '.elasticsearch.hosts' )
c_elc_ssl=$(    echo "${PARSE_JSON}" | jq '.elasticsearch.ssl' )

if [ "${c_aggregate}" = "null" ];  then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.general += {save_aggregate: "'"${AGGREGATE}"'"}' ); fi
if [ "${c_forensic}"  = "null" ];  then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.general += {save_forensic: "'"${FORENSIC}"'"}' ); fi

if [ "${c_imap_host}"  = "null" ]; then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.imap += {host: "'"${IMAP_HOST}"'"}' ); fi
if [ "${c_imap_user}"  = "null" ]; then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.imap += {user: "'"${IMAP_USER}"'"}' ); fi
if [ "${c_imap_pass}"  = "null" ]; then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.imap += {password: "'"${IMAP_PASSWORD}"'"}' ); fi
if [ "${c_imap_watch}" = "null" ]; then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.imap += {watch: "'"${IMAP_WATCH}"'"}' ); fi

if [ ! $( echo "${NO_ELC}" | tr '[:upper:]' '[:lower:]' ) = 'true' ]; then
    if [ "${c_elc_hosts}" = "null" ]; then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.elasticsearch += {hosts: "'"${ELC_HOST}:${ELC_PORT}"'"}' ); fi
    if [ "${c_elc_ssl}"   = "null" ]; then PARSE_JSON=$( echo "${PARSE_JSON}" | jq '.elasticsearch += {ssl: "'"${ELC_SSL}"'"}' ); fi
fi

echo "${PARSE_JSON}" | jq '{ data: . }' | j2 --format=json /config/parsedmarc.ini.j2 > /config/parsedmarc.ini

exec "$@"
