# Nats Configuration
Installation and config nats clustser, make run.sh:

```sh
docker run -d -t --net apinet \
--restart=unless-stopped \
-h $node \
--ip $ipaddr \
--name $node \
nats-streaming \
-p 4223 -m 8223 \
-cid vbid \
--cluster nats://0.0.0.0:6223 \
--routes nats-route://l72.18.0.18:6223,nats-route://172.18.0.18:6223 \
--cluster_node_id c \
--cluster_peers a,b
```


```sh
port: 4223
cluster {
  listen: 0.0.0.0:6223
  routes: [
    "nats-route://localhost:6221",
    "nats-route://localhost:6222",
  ]
}

streaming {
  id: test
  store: file
  dir: storec
  cluster {
    node_id: "c"
    peers: ["a", "b"]
  }
}
```
