package models

import (
	"database/sql"
)

type Address struct {
	Addr_id     int            `json: "addr_id"`
	Addr_uuid   string         `json: "addr_uuid"`
	Line_1      sql.NullString `json: "line_1"`
	Line_2      sql.NullString `json: "line_2"`
	Line_3      sql.NullString `json: "line_3"`
	City        sql.NullString `json: "city"`
	County      sql.NullString `json: "county"`
	State       sql.NullString `json: "state"`
	Postal_code sql.NullString `json: "postal_code"`
	Created     sql.NullString `json: "created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by  sql.NullString `json: "created_by"`
	Modified    sql.NullString `json: "modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by sql.NullString `json: "modified_by"`
}
