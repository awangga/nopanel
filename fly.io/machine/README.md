# Machine 
Create Dockerfile 
```dockerfile
FROM alpine:3.18
WORKDIR /go/app
COPY api .
RUN apk add --no-cache bash tzdata
ENV TZ=Asia/Jakarta
EXPOSE 8080
ENTRYPOINT ["./api"]
```
then 
```sh
flyctl launch
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
