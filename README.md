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

```yml
---

version: '3'

services:

  parsedmarc:
    image: devopsansiblede/parsedmarc
    restart: unless-stopped
    depends_on:
      elasticsearch:
        condition: service_healthy

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch
    environment:
      - cluster.name=parsedmarc
      - discovery.type=single-node
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./data/elasticsearch/data/:/usr/share/elasticsearch/data/:z
    restart: "unless-stopped"
    healthcheck:
      test: ["CMD", "curl","-s" ,"-f", "http://localhost:9200/_cat/health"]
      interval: 1m
      timeout: 10s
      retries: 3
      start_period: 30s

  kibana:
    image: docker.elastic.co/kibana/kibana
    environment:
      SERVER_NAME: "parsedmarc"
      SERVER_HOST: "0.0.0.0"
      ELASTICSEARCH_HOSTS: "http://elasticsearch:9200"
      XPACK_MONITORING_UI_CONTAINER_ELASTICSEARCH_ENABLED: "true"
    ports:
      - "80:5601"
    restart: unless-stopped
    depends_on:
      elasticsearch:
        condition: service_healthy

...
```

Don't forget to import `export.ndjson` – follow instructions on [official documentation](https://domainaware.github.io/parsedmarc/#elasticsearch-and-kibana).

## last built

2021-06-20 23:28:30
