FROM golang:1.17.1-alpine

LABEL mantainer="Enrique Pernia"
LABEL reviewer="holded"

WORKDIR /app
COPY ./app/ .

EXPOSE 8080

CMD [ "go", "run", "server.go" ]