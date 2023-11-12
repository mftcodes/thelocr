package models

import (
	"database/sql"
)

type Resource struct {
	Res_id        int            `json: "res_id"`
	Res_uuid      string         `json: "res_uuid"`
	Res_title     sql.NullString `json: "res_title"`
	Res_desc      sql.NullString `json: "res_desc"`
	Url           sql.NullString `json: "url"`
	Is_parent     bool           `json: "is_parent"`
	Parent_uuid   sql.NullString `json: "parent_uuid"`
	Is_statewide  bool           `json: "is_statewide"`
	Is_nationwide bool           `json: "is_nationwide"`
	Keyword       sql.NullString `json: "keyword"`
	Created       sql.NullString `json: "created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by    sql.NullString `json: "created_by"`
	Modified      sql.NullString `json: "modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by   sql.NullString `json: "modified_by"`
}

type ResourceInsert struct {
	Created_by   string `json: "created_by"`
	Res_title    string `json: "res_title"`
	Res_desc     string `json: "res_desc"`
	Url          string `json: "url"`
	Is_parent    bool   `json: "is_parent"`
	Parent_uuid  string `json: "parent_uuid"`
	Is_statewide bool   `json: "is_statewide"`
	Keyword      string `json: "keyword"`
	Line_1       string `json: "line_1"`
	Line_2       string `json: "line_2"`
	City         string `json: "city"`
	County       string `json: "county"`
	State        string `json: "state"`
	Postal_code  string `json: "postal_code"`
	Phone_1      string `json: "phone_1"`
	Phone_2      string `json: "phone_2"`
	Phone_tty    string `json: "phone_tty"`
	Fax          string `json: "fax"`
	Email        string `json: "email"`
	Category_id  int    `json: "cat_id"`
}
