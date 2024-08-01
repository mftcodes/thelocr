package models

import (
	"database/sql"
)

type Category struct {
	Cat_id      int            `json:"Cat_id"`
	Cat_title   string         `json:"Cat_title"`
	Cat_desc    string         `json:"Cat_desc"`
	Created     sql.NullString `json:"Created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by  sql.NullString `json:"Created_by"`
	Modified    sql.NullString `json:"Modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by sql.NullString `json:"Modified_by"`
}
