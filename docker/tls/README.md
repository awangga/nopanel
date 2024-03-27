#  tls: failed to verify certificate: x509: certificate signed by unknown authority

add this into alpine docker file

```dockerfile
RUN apk add --no-cache ca-certificates && update-ca-certificates
```