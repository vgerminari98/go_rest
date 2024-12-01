FROM golang:1.23.3-alpine

RUN apk update && apk add --no-cache ca-certificates git curl && \
    go install github.com/swaggo/swag/cmd/swag@latest

WORKDIR /app

COPY go.mod ./ 
COPY go.sum ./ 
RUN go mod download

COPY . .

RUN swag init -g ./cmd/server/main.go -o ./docs

RUN go build -o ./cmd/binary/server ./cmd/server/main.go

RUN chmod -R 755 ./cmd/binary

EXPOSE 8080

CMD ["./cmd/binary/server"]
