FROM golang:1.17.1-alpine

LABEL mantainer="Enrique Pernia"
LABEL reviewer="holded"

# gcc
RUN apk add build-base 

WORKDIR /app
COPY ./app/ .

RUN go mod init server.go

EXPOSE 8080

CMD [ "go", "run", "server.go" ]