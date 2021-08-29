ARG OEL_BASE_IMAGE
FROM ${OEL_BASE_IMAGE} as the-latest

RUN if [ $(cat /etc/redhat-release | awk '{print $6}' | tr '.' ' ' | awk '{print $1}') == "7" ]; then \
    ln -s /usr/bin/yum /usr/bin/microdnf;  \
    else  \
    ln -s /usr/bin/microdnf /usr/bin/pkgmgmt; \
    fi && pkgmgmt update -y && pkgmgmt upgrade -y

FROM the-latest

ARG GOLANG_VERSION
ARG GO_BINARY_SHA256

ENV PATH /usr/local/go/bin:$PATH
ENV GO_BINARY_SHA256=${GO_BINARY_SHA256:-"6bf89fc4f5ad763871cf7eac80a2d594492de7a818303283f1366a7f6a30372d"}
ENV PATH /usr/local/go/bin:$PATH

RUN pkgmgmt install wget tar gzip -y && \
    wget -O go.tgz https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz --progress=dot:giga && \
    echo "$GO_BINARY_SHA256 *go.tgz" | sha256sum -c - && \
    tar -C /usr/local -xzf go.tgz && \
    rm go.tgz && \
    go version


ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH
