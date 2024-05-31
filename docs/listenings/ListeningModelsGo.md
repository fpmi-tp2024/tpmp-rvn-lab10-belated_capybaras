
# Listening Models.go

## models

```go
package models
```
- ### User представляет пользователя.
```go
type User struct {
	Username    string `json:"username" db:"username"`
	Email       string `json:"email" db:"email"`
	Password    string `json:"password" db:"password"`
	City        string `json:"city" db:"location_city"`
	Description string `json:"description" db:"description"`
	Photo       []byte `json:"photo" db:"photo"`
}
```
- ### Dog представляет собаку.
```go
type Dog struct {
	ID               int    `json:"id" db:"id"`
	Name             string `json:"name" db:"name"`
	Age              string `json:"age" db:"age"`
	Weight           string `json:"weight" db:"weight"`
	Photo            []byte `json:"image" db:"photo"`
	Description      string `json:"description" db:"description"`
	ShortDescription string `json:"shortDescription" db:"short_description"`
	ShelterEmail     string `json:"shelter_email" db:"shelter_email"`
}
```

