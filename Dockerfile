# Use Go 1.23.3 com base Alpine
FROM golang:1.23.3-alpine

# Instale dependências necessárias
RUN apk update && apk add --no-cache ca-certificates git

# Configure o diretório de trabalho dentro do container
WORKDIR /app

# Copie o go.mod e go.sum antes de instalar as dependências
COPY go.mod ./ 
COPY go.sum ./ 
RUN go mod download

# Copie o restante do código da aplicação
COPY . .

# Compile o binário do servidor com um nome fixo
RUN go build -o ./cmd/binary/server ./cmd/server/main.go

# Garanta que os arquivos na pasta 'binary' sejam executáveis
RUN chmod -R 755 ./cmd/binary

# Porta padrão usada pelo servidor
EXPOSE 8080

# Execute o binário fixo
CMD ["./cmd/binary/server"]
