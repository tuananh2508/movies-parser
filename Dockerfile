FROM golang:1.13.4
ENV VERSION 1.0.22
ENV GOCACHE /tmp
WORKDIR /go/src/github/mlabouardy/movies-parser
RUN wget https://github.com/sonatype-nexus-community/nancy/releases/download/v1.0.30/nancy-v1.0.30-linux-amd64 \
    && mv nancy-v1.0.30-linux-amd64 nancy \
    && mv nancy /usr/local/bin/ \
    && chmod +x /usr/local/bin/nancy 
RUN go get -u golang.org/x/lint/golint
COPY . .
RUN go get -v
