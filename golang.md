# Golang Dev Guide

Setup timezone
```sh
sudo dpkg-reconfigure tzdata
date
```
Installation
```sh
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
```
Install Supporting Tools
```sh
sudo apt install unzip
sudo apt install python3-pip
sudo pip install gdown
```

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

commit and push your code first

```sh
go get -u all
go mod tidy
git tag                                 #check current version
git tag v0.0.3                          #set tag version
git push origin --tags                  #push tag version to repo
go list -m github.com/ORG/REPO@v0.0.3   #publish to pkg dev, replace ORG/URL with your repo URL
```
