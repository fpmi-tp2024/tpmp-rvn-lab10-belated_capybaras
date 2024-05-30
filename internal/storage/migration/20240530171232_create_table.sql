-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS users (
    username TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    location_city TEXT,
    description TEXT,
    photo BYTEA
);

CREATE TABLE IF NOT EXISTS shelters(
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    name TEXT,
    location_city TEXT,
    bill TEXT,
    description TEXT,
    photo BYTEA
);

CREATE TABLE IF NOT EXISTS dogs(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INT,
    weight DECIMAL,
    photo BYTEA,
    description TEXT,
    short_description TEXT,
    shelter_email TEXT NOT NULL REFERENCES shelters(email)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS dogs;
DROP TABLE IF EXISTS shelters;
-- +goose StatementEnd
