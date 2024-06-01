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
	_, err := s.db.Exec("INSERT INTO users (username, email, password, city, photo) VALUES ($1, $2, $3, $4, $5)",
		user.Username, user.Email, user.Password, user.City, user.Photo)
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
		imageData, err := ioutil.ReadFile(fmt.Sprintf("backend/src/dogs/%d.png", i+1))
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

func (s *Storage) UpdateUser(user models.User) error {
	_, err := s.db.Exec("UPDATE users SET name=$1,surname=$2,city=$3,photo=$4 WHERE email=$5",
		user.Name, user.Surname, user.City, user.Photo, user.Email)
	if err != nil {
		return err
	}

	return nil
}

func (s *Storage) GetUserInfo(email string) (models.User, error) {
	var user models.User
	err := s.db.Get(&user, "SELECT * FROM users WHERE email=$1", email)
	if err != nil {
		return models.User{}, err
	}

	return user, nil
}

func (s *Storage) AddPhotoForMaxim() {
	imageData, err := ioutil.ReadFile("backend/src/people/8.jpg")
	if err != nil {
		log.Fatal(err)
	}

	_, err = s.db.Exec("UPDATE users SET photo = $1 WHERE email = $2", imageData, "maximbaranovskiy@gmail.com")
	if err != nil {
		log.Fatal(err)
	}
}

func (s *Storage) GetShelterDogs(email string) ([]models.Dog, error) {
	dogs := []models.Dog{}
	err := s.db.Select(&dogs, "SELECT * FROM dogs WHERE shelter_email=$1", email)
	if err != nil {
		return nil, err
	}

	return dogs, nil
}

func (s *Storage) GetShelterInfo(email string) (models.Shelter, error) {
	var shelter models.Shelter
	err := s.db.Get(&shelter, "SELECT * FROM shelters WHERE email=$1", email)
	if err != nil {
		return models.Shelter{}, err
	}

	return shelter, nil
}

func (s *Storage) UpdateShelter(shelter models.Shelter) error {
	_, err := s.db.Exec("UPDATE shelters SET name=$1,bill=$2,photo=$3,description=$4 WHERE email=$5",
		shelter.Username, shelter.Bill, shelter.Photo, shelter.Description, shelter.Email)
	if err != nil {
		return err
	}

	return nil
}

func (s *Storage) AddDog(dog models.Dog) error {
	_, err := s.db.Exec("INSERT INTO dogs (name, age, weight, photo, description, short_description, shelter_email) VALUES ($1, $2, $3, $4, $5, $6, $7)",
		dog.Name, dog.Age, dog.Weight, dog.Photo, dog.Description, dog.ShortDescription, dog.ShelterEmail)
	if err != nil {
		return err
	}

	return nil
}
