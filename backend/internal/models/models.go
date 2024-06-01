package models

type User struct {
	Username string `json:"username" db:"username"`
	Name     string `json:"name" db:"name"`
	Surname  string `json:"surname" db:"surname"`
	Email    string `json:"email" db:"email"`
	Password string `json:"password" db:"password"`
	City     string `json:"city" db:"city"`
	Photo    []byte `json:"image" db:"photo"`
}

type Dog struct {
	ID               int    `json:"id" db:"id"`
	Name             string `json:"name" db:"name"`
	Age              string `json:"age" db:"age"`
	Weight           string `json:"weight" db:"weight"`
	Photo            []byte `json:"image" db:"photo"`
	Description      string `json:"description" db:"description"`
	ShortDescription string `json:"shortDescription" db:"short_description"`
	ShelterEmail     string `json:"shelterEmail" db:"shelter_email"`
}

type Shelter struct {
	Email       string `json:"email" db:"email"`
	Password    string `json:"password" db:"password"`
	Name        string `json:"name" db:"name"`
	Username    string `json:"username" db:"username"`
	Bill        string `json:"bill" db:"bill"`
	Photo       []byte `json:"image" db:"photo"`
	Description string `json:"description" db:"description"`
}
