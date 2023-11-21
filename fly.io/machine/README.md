# Machine
Run launch for the first time creating app
```sh
flyctl launch
```
Edit fly.toml file 
```toml
app = "wamyid"
primary_region = "sin"

[build]
  builder = "paketobuildpacks/builder:base"
  buildpacks = ["gcr.io/paketo-buildpacks/go"]

[http_service]
  internal_port = 8080
  force_https = true
  auto_stop_machines = false
  auto_start_machines = true
  min_machines_running = 1
  processes = ["app"]
```
then 
```sh
flyctl deploy --ha=false && flyctl scale count 1 -y
flyctl scale count 1 -a wamyid
```
edit fly.toml data

```sh
flyctl volumes create wamyid_data --size=1
fly machine run . --file-local /go/app/api=api

```

https://fly.io/docs/machines/

https://www.callicoder.com/docker-golang-image-container-example/
