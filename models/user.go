package models

import (
	"database/sql"
	"database/sql/driver"
	"errors"
)

type User struct {
	User_id     int            `json:"User_id"`
	User_uuid   string         `json:"User_uuid"`
	Email       string         `json:"User_email"`
	Username    string         `json:"Username"`
	First_name  string         `json:"First_name"`
	Last_name   string         `json:"Last_name"`
	Password    string         `json:"Password"`
	Can_edit    BitBool        `json:"Can_edit"`
	Created     sql.NullString `json:"Created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified    sql.NullString `json:"Modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by sql.NullString `json:"Modified_by"`
}

type UserCreate struct {
	Email      string `json:"User_email"`
	Username   string `json:"Username"`
	First_name string `json:"First_name"`
	Last_name  string `json:"Last_name"`
	Password   string `json:"Password"`
}

type UserLogin struct {
	Username string `json:"Username"`
	Password string `json:"Password"`
}

// BitBool is an implementation of a bool for the MySQL type BIT(1).
// This type allows you to avoid wasting an entire byte for MySQL's boolean type TINYINT.
type BitBool bool

// Value implements the driver.Valuer interface,
// and turns the BitBool into a bitfield (BIT(1)) for MySQL storage.
func (b BitBool) Value() (driver.Value, error) {
	if b {
		return []byte{1}, nil
	} else {
		return []byte{0}, nil
	}
}

// Scan implements the sql.Scanner interface,
// and turns the bitfield incoming from MySQL into a BitBool
func (b *BitBool) Scan(src interface{}) error {
	v, ok := src.([]byte)
	if !ok {
		return errors.New("bad []byte type assertion")
	}
	*b = v[0] == 1
	return nil
}
