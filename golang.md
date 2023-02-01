# Golang Dev Guide

## Testing The Function
Make file repo_test.go

```go
package watoken

import (
    "encoding/base64"
    "fmt"
    "testing"

    "github.com/stretchr/testify/require"
)

func TestWacipher(t *testing.T) {
    tokenstring, err := EncodeforSeconds(userid, privateKey, 60)
    require.NoError(t, err)

    n := 100
    rnd := RandomString(n)
    require.Len(t, rnd, n)
    fmt.Println("rnd : ", rnd)

    wh := GetAppSubDomain("https://www.gombel.com/js/sapi.asp")
    require.Equal(t, "www", wh)
    fmt.Println("wh : ", wh)
}
```

## Release A Package

Set Environtment variabel:

GOPROXY=proxy.golang.org

```sh
git tag
git tag v0.0.1
git push origin --tags
go list -m github.com/ORG/REPO@v0.0.1
```
