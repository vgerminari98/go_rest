FROM golang:1.23.3-alpine

RUN apk update && apk add --no-cache ca-certificates git

WORKDIR /app

COPY go.mod ./ 
COPY go.sum ./ 
RUN go mod download

COPY . .

# Compile o binário do servidor com um nome fixo
RUN go build -o ./cmd/binary/server ./cmd/server/main.go

# Garanta que os arquivos na pasta 'binary' sejam executáveis
RUN chmod -R 755 ./cmd/binary

# Porta padrão usada pelo servidor
EXPOSE 8080

# Execute o binário fixo
CMD ["./cmd/binary/server"]
