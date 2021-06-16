# parseDMARC

This Docker-Image is meant to provide an installed version of [`parseDMARC`](https://pypi.org/project/parsedmarc/).

## Variables

| env               | default           | change recommended | description |
| ----------------- | ----------------- |:------------------:| ----------- |
| **IMAP_HOST**     |                   | yes                | IMAP host to connect to |
| **IMAP_USER**     |                   | yes                | IMAP user to connect with to the IMAP Host |
| **IMAP_PASSWORD** |                   | yes                | IMAP password for IMAP user |
| **AGGREGATE**     | *"True"*          | no                 | `general.save_aggregate`: (Python) boolean – save aggregate report data |
| **FORENSIC**      | *"True"*          | no                 | `general.save_forensic`: (Python) boolean – save forensic report data |
| **PARSE_JSON**    | *{}*              | yes                | JSON string, that holds hierarchical config data (`general.save_aggregate` would override `AGGREGATE`, if defined as `{ "general": { "save_aggregate": "False" }}` e.g.) |
| **ELC_HOST**      | *"http://elasticsearch"* | no          | part of `elasticsearch.hosts`: Host of Elastic Search – change if not using `docker-compose.yml` below. |
| **ELC_PORT**      | *"9200"*          | no                 | part of `elasticsearch.hosts`: Port of Elastic Search – change if not using `docker-compose.yml` below. |
| **ELC_SSL**       | *"False"*         | no                 | `elasticsearch.ssl`: SSL status of Elastic Search connection – change if not using `docker-compose.yml` below. |

## `docker-compose.yml`

To be defined.

## last built

2021-06-16 19:10:34
