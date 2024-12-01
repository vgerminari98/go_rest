package main

// importação das libs

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

// rota de health
func HealthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("OK"))
}

func main() {
	// função responsável por gerenciar a rota
	router := mux.NewRouter()

	// Define a rota de health e define meteodo de chamado
	router.HandleFunc("/health", HealthHandler).Methods("GET")

	// Inicia o servidor
	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", router); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
