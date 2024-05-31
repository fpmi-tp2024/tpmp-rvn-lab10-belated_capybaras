package server

import (
	"net/http"
	"time"
)

type Handler interface {
	HandleUserRegister(w http.ResponseWriter, r *http.Request)
	HandleUserLogin(w http.ResponseWriter, r *http.Request)
	HandleGetUserInfo(w http.ResponseWriter, r *http.Request)
	HandleGetDogs(w http.ResponseWriter, r *http.Request)
	HandleTakeADog(w http.ResponseWriter, r *http.Request)
	HandleShelterRegister(w http.ResponseWriter, r *http.Request)
	HandleShelterLogin(w http.ResponseWriter, r *http.Request)
	HandleUpdateUser(w http.ResponseWriter, r *http.Request)
}

type Server struct {
	httpServer *http.Server
}

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

func initRoutes(h Handler, mux *http.ServeMux) {
	mux.HandleFunc("/users/register", h.HandleUserRegister)
	mux.HandleFunc("/users/login", h.HandleUserLogin)
	mux.HandleFunc("/dogs", h.HandleGetDogs)
	mux.HandleFunc("/dogs/take", h.HandleTakeADog)
	mux.HandleFunc("/shelters/register", h.HandleShelterRegister)
	mux.HandleFunc("/shelters/login", h.HandleShelterLogin)
	mux.HandleFunc("/users/update", h.HandleUpdateUser)
	mux.HandleFunc("/users/info", h.HandleGetUserInfo)
}
