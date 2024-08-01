package models

import (
	"database/sql"
)

type Contact struct {
	Con_id      int            `json:"Con_id"`
	Con_uuid    string         `json:"Con_uuid"`
	Phone_1     sql.NullString `json:"Phone_1"`
	Phone_2     sql.NullString `json:"Phone_2"`
	Phone_tty   sql.NullString `json:"Phone_tty"`
	Fax         sql.NullString `json:"Fax"`
	Email       sql.NullString `json:"Email"`
	Created     sql.NullString `json:"Created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by  sql.NullString `json:"Created_by"`
	Modified    sql.NullString `json:"Modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by sql.NullString `json:"Modified_by"`
}
