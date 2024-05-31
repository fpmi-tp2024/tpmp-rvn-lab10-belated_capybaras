
# Listening Server.go

## server

```go
package server

import (
	"net/http"
	"time"
)
```
- ### Handler определяет методы для обработки запросов.
```go
type Handler interface {
	HandleUserRegister(w http.ResponseWriter, r *http.Request)
	HandleUserLogin(w http.ResponseWriter, r *http.Request)
	HandleGetDogs(w http.ResponseWriter, r *http.Request)
	HandleTakeADog(w http.ResponseWriter, r *http.Request)
}
```
- ### Server представляет HTTP сервер.
```go
type Server struct {
	httpServer *http.Server
}
```
- ### Run запускает сервер на заданном порту с указанным обработчиком.
```go
func (s *Server) Run(port string, h Handler) error {
	mux := &http.ServeMux{}

	initRoutes(h, mux)

	s.httpServer = &http.Server{
		Addr:           ":" + port,
		Handler:        mux,
		MaxHeaderBytes: 1 << 20,
		ReadTimeout:    30 * time.Second,
		WriteTimeout:   30 * time.Second,
	}

	return s.httpServer.ListenAndServe()
}
```
- ### initRoutes инициализирует маршруты для сервера.
```go
func initRoutes(h Handler, mux *http.ServeMux) {
	mux.HandleFunc("/users/register", h.HandleUserRegister)
	mux.HandleFunc("/users/login", h.HandleUserLogin)
	mux.HandleFunc("/dogs", h.HandleGetDogs)
	mux.HandleFunc("/dogs/take", h.HandleTakeADog)
}
```

