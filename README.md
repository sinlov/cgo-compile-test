## cgo build test

- env

```bash
# macOS
$ sw_vers
ProductName:    macOS
ProductVersion: 11.4
BuildVersion:   20F71
# go version
go version go1.16.2 darwin/amd64
# go env
GO111MODULE="on"
GOARCH="amd64"
GOBIN=""
GOCACHE="/Users/sinlov/Library/Caches/go-build"
GOENV="/Users/sinlov/Library/Application Support/go/env"
GOEXE=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="darwin"
GOINSECURE=""
GOMODCACHE="/Users/sinlov/go/pkg/mod"
GONOPROXY="*.gitlab.com,*.gitea.com"
GONOSUMDB="*.gitlab.com,*.gitea.com"
GOOS="darwin"
GOPATH="/Users/sinlov/go"
GOPRIVATE="*.gitlab.com,*.gitea.com"
GOPROXY="https://goproxy.cn,direct"
GOROOT="/usr/local/opt/go/libexec"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/opt/go/libexec/pkg/tool/darwin_amd64"
GOVCS=""
GOVERSION="go1.16.2"
GCCGO="gccgo"
AR="ar"
CC="clang"
CXX="clang++"
CGO_ENABLED="1"
GOMOD="/Users/sinlov/go/src/github.com/sinlov/cgo-compile-test/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -arch x86_64 -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fdebug-prefix-map=/var/folders/tm/2y07gxzj72x_nc91rxq7w9_80000gn/T/go-build766165709=/tmp/go-build -gno-record-gcc-switches -fno-common"
```

## cgo build error

- [github/golang/go/issues/47546](https://github.com/golang/go/issues/47546)

- error ar

```bash
$ make
...

file test.a
test.a: current ar archive
```

- want ar

```bashg
$ make
...

file test.a
test.a: current ar archive random library
```

go build args

```
CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 go build -ldflags "-w" -x -v -buildmode=c-archive
```