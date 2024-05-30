package models

type User struct {
	Username    string `json:"username" db:"username"`
	Email       string `json:"email" db:"email"`
	Password    string `json:"password" db:"password"`
	City        string `json:"city" db:"location_city"`
	Description string `json:"description" db:"description"`
	Photo       []byte `json:"photo" db:"photo"`
}

type Dog struct {
	ID               int     `json:"id" db:"id"`
	Name             string  `json:"name" db:"name"`
	Age              int     `json:"age" db:"age"`
	Weight           float64 `json:"weight" db:"weight"`
	Photo            []byte  `json:"photo" db:"photo"`
	Description      string  `json:"description" db:"description"`
	ShortDescription string  `json:"short_description" db:"short_description"`
	ShelterEmail     string  `json:"shelter_email" db:"shelter_email"`
}
