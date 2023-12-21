package models

import (
	"database/sql"
)

type Category struct {
	Cat_id      int            `json: "cat_id"`
	Cat_title   string         `json: "cat_title"`
	Cat_desc    string         `json: "cat_desc"`
	Created     sql.NullString `json: "created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by  sql.NullString `json: "created_by"`
	Modified    sql.NullString `json: "modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by sql.NullString `json: "modified_by"`
}
