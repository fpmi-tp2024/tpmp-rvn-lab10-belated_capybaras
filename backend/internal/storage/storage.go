package storage

import (
	"fmt"
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	"io/ioutil"
	"log"
	"petAPI/backend/internal/models"
)

type Storage struct {
	db *sqlx.DB
}

func NewStorage() (*Storage, error) {
	db, err := sqlx.Open("postgres", "host=localhost user=postgres password=summerquantitylanguage dbname=petAPI sslmode=disable")
	if err != nil {
		return nil, err
	}

	if err = db.Ping(); err != nil {
		return nil, err
	}

	return &Storage{db}, nil
}

func (s *Storage) AddUser(user models.User) error {
	_, err := s.db.Exec("INSERT INTO users (username, email, password, location_city, description, photo) VALUES ($1, $2, $3, $4, $5, $6)",
		user.Username, user.Email, user.Password, user.City, user.Description, user.Photo)
	if err != nil {
		return err
	}

	return nil
}

func (s *Storage) CheckUser(user models.User) error {
	var u models.User
	err := s.db.Get(&u, "SELECT * FROM users WHERE email=$1 AND password=$2", user.Email, user.Password)
	if err != nil {
		return err
	}

	return nil
}

func (s *Storage) AddMockDogInformation() {
	names := []string{"Bella", "Lucy", "Max", "Charlie", "Daisy", "Buddy", "Sadie", "Molly", "Bailey", "Lola"}
	ages := []string{"2", "3", "1", "5", "4", "6", "3", "7", "2", "1"}
	weights := []float64{10.5, 20.5, 30.5, 40.5, 25.5, 35.5, 45.5, 28.5, 38.5, 48.5}
	descriptions := []string{"Friendly and playful", "Loves to cuddle", "Enjoys walks", "Very active", "Loves to eat", "Sleeps a lot", "Loves to play fetch", "Enjoys car rides", "Loves water", "Great with kids"}
	shortDescriptions := []string{"Playful", "Cuddly", "Active", "Energetic", "Hungry", "Sleepy", "Fetch-lover", "Car-lover", "Swimmer", "Kid-friendly"}
	shelterEmails := []string{"admin", "admin", "admin", "admin", "admin", "admin", "admin", "admin", "admin", "admin"}

	for i := 0; i < 10; i++ {
		imageData, err := ioutil.ReadFile(fmt.Sprintf("backend/src/%d.png", i+1))
		if err != nil {
			log.Fatal(err)
		}

		_, err = s.db.Exec("INSERT INTO dogs (name, age, weight, photo, description, short_description, shelter_email) VALUES ($1, $2, $3, $4, $5, $6, $7)",
			names[i], ages[i], weights[i], imageData, descriptions[i], shortDescriptions[i], shelterEmails[i])
		if err != nil {
			log.Fatal(err)
		}
	}
}

func (s *Storage) GetDogs() ([]models.Dog, error) {
	dogs := []models.Dog{}
	err := s.db.Select(&dogs, "SELECT * FROM dogs")
	if err != nil {
		return nil, err
	}

	return dogs, nil
}

func (s *Storage) DeleteDog(id int) error {
	_, err := s.db.Exec("DELETE FROM dogs WHERE id=$1", id)
	if err != nil {
		return err
	}

	return nil
}

func (s *Storage) AddShelter(shelter models.Shelter) error {
	_, err := s.db.Exec("INSERT INTO shelters (email, password, name, username, bill, photo) VALUES ($1, $2, $3, $4, $5, $6)",
		shelter.Email, shelter.Password, shelter.Name, shelter.Username, shelter.Bill, shelter.Photo)
	if err != nil {
		return err
	}

	return nil
}

func (s *Storage) CheckShelter(shelter models.Shelter) error {
	var sh models.Shelter
	err := s.db.Get(&sh, "SELECT * FROM shelters WHERE email=$1 AND password=$2", shelter.Email, shelter.Password)
	if err != nil {
		fmt.Println(err)
		return err
	}

	return nil
}
