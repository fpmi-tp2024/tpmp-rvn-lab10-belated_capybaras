
# Listening Storage.go

## storage

```go
package storage

import (
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	"io/ioutil"
	"log"
	"petAPI/backend/internal/models"
)
```
- ### Storage представляет хранилище с подключением к базе данных.
```go
type Storage struct {
	db *sqlx.DB
}
```
- ### NewStorage создает новое подключение к базе данных.
```go
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
```
- ### AddUser добавляет нового пользователя в базу данных.
```go
func (s *Storage) AddUser(user models.User) error {
	_, err := s.db.Exec("INSERT INTO users (username, email, password, location_city, description, photo) VALUES ($1, $2, $3, $4, $5, $6)",
		user.Username, user.Email, user.Password, user.City, user.Description, user.Photo)
	if err != nil {
		return err
	}

	return nil
}
```
- ### CheckUser проверяет пользователя в базе данных.
```go
func (s *Storage) CheckUser(user models.User) error {
	var u models.User
	err := s.db.Get(&u, "SELECT * FROM users WHERE email=$1 AND password=$2", user.Email, user.Password)
	if err != nil {
		return err
	}

	return nil
}
```
- ### AddMockDogInformation добавляет тестовую информацию о собаках в базу данных.
```go
func (s *Storage) AddMockDogInformation() {
	names := []string{"name1", "name2", "name3", "name4"}
	ages := []string{"1", "2", "3", "4"}
	weights := []float64{10.5, 20.5, 30.5, 40.5}
	descriptions := []string{"description1", "description2", "description3", "description4"}
	shortDescriptions := []string{"short_description1", "short_description2", "short_description3", "short_description4"}
	shelterEmails := []string{"admin", "admin", "admin", "admin"}

	for i := 0; i < 4; i++ {
		imageData, err := ioutil.ReadFile("src/" + "1.jpg")
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
```
- ### GetDogs получает список всех собак из базы данных.
```go
func (s *Storage) GetDogs() ([]models.Dog, error) {
	dogs := []models.Dog{}
	err := s.db.Select(&dogs, "SELECT * FROM dogs")
	if err != nil {
		return nil, err
	}

	return dogs, nil
}
```
- ### DeleteDog удаляет собаку из базы данных по её идентификатору.
```go
func (s *Storage) DeleteDog(id int) error {
	_, err := s.db.Exec("DELETE FROM dogs WHERE id=$1", id)
	if err != nil {
		return err
	}

	return nil
}
```


# Listening Storage.go

## storage

```go
package storage

import (
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	"io/ioutil"
	"log"
	"petAPI/backend/internal/models"
)
```
- ### Storage представляет хранилище с подключением к базе данных.
```go
type Storage struct {
	db *sqlx.DB
}
```
- ### NewStorage создает новое подключение к базе данных.
```go
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
```
- ### AddUser добавляет нового пользователя в базу данных.
```go
func (s *Storage) AddUser(user models.User) error {
	_, err := s.db.Exec("INSERT INTO users (username, email, password, location_city, description, photo) VALUES ($1, $2, $3, $4, $5, $6)",
		user.Username, user.Email, user.Password, user.City, user.Description, user.Photo)
	if err != nil {
		return err
	}

	return nil
}
```
- ### CheckUser проверяет пользователя в базе данных.
```go
func (s *Storage) CheckUser(user models.User) error {
	var u models.User
	err := s.db.Get(&u, "SELECT * FROM users WHERE email=$1 AND password=$2", user.Email, user.Password)
	if err != nil {
		return err
	}

	return nil
}
```
- ### AddMockDogInformation добавляет тестовую информацию о собаках в базу данных.
```go
func (s *Storage) AddMockDogInformation() {
	names := []string{"name1", "name2", "name3", "name4"}
	ages := []string{"1", "2", "3", "4"}
	weights := []float64{10.5, 20.5, 30.5, 40.5}
	descriptions := []string{"description1", "description2", "description3", "description4"}
	shortDescriptions := []string{"short_description1", "short_description2", "short_description3", "short_description4"}
	shelterEmails := []string{"admin", "admin", "admin", "admin"}

	for i := 0; i < 4; i++ {
		imageData, err := ioutil.ReadFile("src/" + "1.jpg")
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
```
- ### GetDogs получает список всех собак из базы данных.
```go
func (s *Storage) GetDogs() ([]models.Dog, error) {
	dogs := []models.Dog{}
	err := s.db.Select(&dogs, "SELECT * FROM dogs")
	if err != nil {
		return nil, err
	}

	return dogs, nil
}
```
- ### DeleteDog удаляет собаку из базы данных по её идентификатору.
```go
func (s *Storage) DeleteDog(id int) error {
	_, err := s.db.Exec("DELETE FROM dogs WHERE id=$1", id)
	if err != nil {
		return err
	}

	return nil
}
```

