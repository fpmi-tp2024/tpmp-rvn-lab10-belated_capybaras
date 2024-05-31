-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS users (
                                     username TEXT NOT NULL,
                                     email TEXT UNIQUE NOT NULL,
                                     password TEXT NOT NULL,
                                     location_city TEXT DEFAULT '',
                                     description TEXT DEFAULT '',
                                     photo BYTEA
);

CREATE TABLE IF NOT EXISTS shelters(
                                       username TEXT NOT NULL,
                                       password TEXT NOT NULL,
                                       email TEXT UNIQUE NOT NULL,
                                       name TEXT Default '',
                                       location_city TEXT Default '',
                                       bill TEXT Default '',
                                       description TEXT Default '',
                                       photo BYTEA
);

CREATE TABLE IF NOT EXISTS dogs(
                                   id SERIAL PRIMARY KEY,
                                   name TEXT NOT NULL,
                                   age TEXT Default '',
                                   weight TEXT Default '',
                                   photo BYTEA,
                                   description TEXT Default '',
                                   short_description TEXT Default '',
                                   shelter_email TEXT NOT NULL REFERENCES shelters(email)
    );
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS dogs;
DROP TABLE IF EXISTS shelters;
-- +goose StatementEnd
