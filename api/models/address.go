package models

import (
	"database/sql"
)

type Address struct {
	Addr_id     int            `json:"Addr_id"`
	Addr_uuid   string         `json:"Addr_uuid"`
	Line_1      sql.NullString `json:"Line_1"`
	Line_2      sql.NullString `json:"Line_2"`
	Line_3      sql.NullString `json:"Line_3"`
	City        sql.NullString `json:"City"`
	County      sql.NullString `json:"County"`
	State       sql.NullString `json:"State"`
	Postal_code sql.NullString `json:"Postal_code"`
	Created     sql.NullString `json:"Created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by  sql.NullString `json:"Created_by"`
	Modified    sql.NullString `json:"Modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by sql.NullString `json:"Modified_by"`
}
