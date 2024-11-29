package main

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

// HealthHandler responde com o status do servidor
func HealthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("OK"))
}

func main() {
	// Cria um novo roteador
	router := mux.NewRouter()

	// Define a rota de health check
	router.HandleFunc("/health", HealthHandler).Methods("GET")

	// Inicia o servidor
	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
