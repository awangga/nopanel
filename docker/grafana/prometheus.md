docker run \
--volume=/:/rootfs:ro \
--volume=/var/run:/var/run:ro \
--volume=/sys:/sys:ro \
--volume=/var/lib/docker/:/var/lib/docker:ro \
--volume=/dev/disk/:/dev/disk:ro \
--publish=8080:8080 \
--detach=true \
--name=cadvisorweb \
gcr.io/google-containers/cadvisor:latest 


docker pull prom/prometheus

prometheus.yml
```sh
# global config
global:
  scrape_interval:     15s
  evaluation_interval: 15s

rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"
# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['172.18.0.251:9090']
  - job_name: 'cadvisor'
    scrape_interval: 10s 
    metrics_path: '/metrics'
    static_configs:
      - targets: ['172.18.0.250:8080','10.104.0.8:8080']
        labels:
          group: 'cadvisor'
```





docker run -d --name prometheus -p 9090:9090 --net apinet --ip 172.18.0.251\
-v $(pwd)/prometheus:/etc/prometheus prom/prometheus \
--config.file=/etc/prometheus/prometheus.yml

cek menu : status → Targets, make sure up


docker run -d --net apinet -p 3000:3000 grafana/grafana

Click on create your first data source
https://grafana.com/grafana/dashboards/193
import dashboard