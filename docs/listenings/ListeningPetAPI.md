
# Listening Main.go

## main

```go
package main

import (
	"petAPI/backend/internal/handlers"
	"petAPI/backend/internal/server"
	"petAPI/backend/internal/storage"
)
```
- ### main функция запускает сервер и инициализирует хранилище и обработчики.
```go
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
```

