package main

import (
	"petAPI/internal/handlers"
	"petAPI/internal/server"
	"petAPI/internal/storage"
)

func main() {
	store, err := storage.NewStorage()
	if err != nil {
		panic(err)
	}

	store.AddMockDogInformation()

	handle := handlers.NewHandler(store)
	s := new(server.Server)
	s.Run("8080", handle)
}
