package models

import (
	"database/sql"
)

type Contact struct {
	Con_id      int            `json: "con_id"`
	Con_uuid    string         `json: "con_uuid"`
	Phone_1     sql.NullString `json: "phone_1"`
	Phone_2     sql.NullString `json: "phone_2"`
	Phone_tty   sql.NullString `json: "phone_tty"`
	Fax         sql.NullString `json: "fax"`
	Email       sql.NullString `json: "email"`
	Created     sql.NullString `json: "created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by  sql.NullString `json: "created_by"`
	Modified    sql.NullString `json: "modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by sql.NullString `json: "modified_by"`
}
