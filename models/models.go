package models

import (
	"time"
)

type Address struct {
	Addr_id int `json:"addr_id"`
	Addr_uuid string `json: "addr_uuid"`
	Line_1 string `json: "line_1"`
	Line_2 string `json: "line_2"`
	Line_3 string `json: "line_3"`
	City string `json: "city"`
	County string `json: "county"`
	State string `json: "state"`
	Postal_code string `json: "postal_code"`
	Created time.Time `json: "created"`
	Created_by string `json: "created_by"`
	Modified time.Time `json: "modified"`
	Modified_by string `json: "modified_by"`
}