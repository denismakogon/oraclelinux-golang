# Golang on Oracle Linux Docker images

## How to build Golang 1.17
```shell
docker build -t denismakogon/oraclelinux7-golang:1.17 --build-arg OEL_BASE_IMAGE="oraclelinux:7-slim" --build-arg GOLANG_VERSION=1.17 -f Dockerfile .

docker build -t denismakogon/oraclelinux8-golang:1.17 --build-arg OEL_BASE_IMAGE="oraclelinux:8-slim" --build-arg GOLANG_VERSION=1.17 -f Dockerfile .
```

## How to build Golang specific version
```shell
docker build -t denismakogon/oraclelinux7-golang:1.17 \
  --build-arg OEL_BASE_IMAGE="oraclelinux:7-slim" \
  --build-arg GOLANG_VERSION=<specific Golang version> \
  --build-arg GO_BINARY_SHA256=<SHA256 of Golang tar.gz archive>
  -f Dockerfile .
```


## How to use

### Oracle Linux 7
```dockerfile
FROM denismakogon/oraclelinux7-golang:1.17 as build-stage
# do you work here
FROM oraclelinux:7-slim
```

### Oracle Linux 8