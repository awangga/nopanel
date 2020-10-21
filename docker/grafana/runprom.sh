docker run -d --name prometheus -p 9090:9090 \
-v $(pwd)/prometheus:/etc/prometheus prom/prometheus \
--config.file=/etc/prometheus/prometheus.yml

