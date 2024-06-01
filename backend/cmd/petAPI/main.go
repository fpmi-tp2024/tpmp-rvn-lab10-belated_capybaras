package main

import (
	"petAPI/backend/internal/handlers"
	"petAPI/backend/internal/server"
	"petAPI/backend/internal/storage"
)

func main() {
	store, err := storage.NewStorage()
	if err != nil {
		panic(err)
	}

	//store.AddMockDogInformation()
	//store.AddPhotoForMaxim()
	store.AddPhotoForSaveAnimals()

	handle := handlers.NewHandler(store)
	s := new(server.Server)
	s.Run("8080", handle)
}
