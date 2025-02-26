package models

import (
	"database/sql"
)

type Resource struct {
	Res_id        int            `json:"Res_id"`
	Res_uuid      string         `json:"Res_uuid"`
	Res_title     sql.NullString `json:"Res_title"`
	Res_desc      sql.NullString `json:"Res_desc"`
	Url           sql.NullString `json:"Url"`
	Is_parent     bool           `json:"Is_parent"`
	Parent_uuid   sql.NullString `json:"Parent_uuid"`
	Is_statewide  bool           `json:"Is_statewide"`
	Is_nationwide bool           `json:"Is_nationwide"`
	Keyword       sql.NullString `json:"Keyword"`
	Created       sql.NullString `json:"Created" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Created_by    sql.NullString `json:"Created_by"`
	Modified      sql.NullString `json:"Modified" time_format:"2006-01-02 03:04:05" time_utc:"0"`
	Modified_by   sql.NullString `json:"Modified_by"`
}

type ResourceDetail struct {
	Res_uuid    string         `json:"Res_uuid"`
	Res_title   sql.NullString `json:"Res_title"`
	Res_desc    sql.NullString `json:"Res_desc"`
	Url         sql.NullString `json:"Url"`
	Addr_uuid   string         `json:"Addr_uuid"`
	Line_1      sql.NullString `json:"Line_1"`
	Line_2      sql.NullString `json:"Line_2"`
	Line_3      sql.NullString `json:"Line_3"`
	City        sql.NullString `json:"City"`
	County      sql.NullString `json:"County"`
	State       sql.NullString `json:"State"`
	Postal_code sql.NullString `json:"Postal_code"`
	Con_uuid    string         `json:"Con_uuid"`
	Phone_1     sql.NullString `json:"Phone_1"`
	Phone_2     sql.NullString `json:"Phone_2"`
	Phone_tty   sql.NullString `json:"Phone_tty"`
	Fax         sql.NullString `json:"Fax"`
	Email       sql.NullString `json:"Email"`
}

type ResourceInsert struct {
	Created_by   string `json:"Created_by"`
	Res_title    string `json:"Res_title"`
	Res_desc     string `json:"Res_desc"`
	Url          string `json:"Url"`
	Is_parent    bool   `json:"Is_parent"`
	Parent_uuid  string `json:"Parent_uuid"`
	Is_statewide bool   `json:"Is_statewide"`
	Keyword      string `json:"Keyword"`
	Line_1       string `json:"Line_1"`
	Line_2       string `json:"Line_2"`
	City         string `json:"City"`
	County       string `json:"County"`
	State        string `json:"State"`
	Postal_code  string `json:"Postal_code"`
	Phone_1      string `json:"Phone_1"`
	Phone_2      string `json:"Phone_2"`
	Phone_tty    string `json:"Phone_tty"`
	Fax          string `json:"Fax"`
	Email        string `json:"Email"`
	Cat_id       int    `json:"Cat_id"`
}

type ResourceSearchBase struct {
	Is_statewide bool   `json:"Is_statewide"`
	County       string `json:"County"`
	State        string `json:"State"`
	Cat_id       int    `json:"Cat_id"`
}

type ResourceEdit struct {
	Address  Address
	Contact  Contact
	Resource Resource
}
