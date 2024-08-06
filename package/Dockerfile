FROM golang:1.20 AS base

WORKDIR /app
COPY . .
RUN go mod download && go mod verify

RUN --mount=type=cache,target=/root/.cache/go-build \
    /bin/sh scripts/build

# -------------------------------------------
FROM registry.suse.com/bci/bci-base:15.4
COPY --from=base /app/bin/manager /bin/manager
RUN zypper -n install ipmitool && zypper clean

WORKDIR /
USER 65532:65532

ENTRYPOINT ["/bin/manager"]
