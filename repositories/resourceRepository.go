package repositories

import (
	"database/sql"
	"fmt"

	"bowen/config"
	"bowen/models"
)

type ResourceRepository struct{}

func (rr *ResourceRepository) Create(res models.ResourceInsert) (sql.Result, error) {
	isParent := boolToBit(res.Is_parent)
	isStatewide := boolToBit(res.Is_parent)

	sql := fmt.Sprintf(`
	CALL minuchin.sp_insertResource('%v','%v','%v','%v',%d,'%v',%d,'%v','%v','%v','%v','%v','%v','%v','%v','%v','%v','%v','%v',%d)`,
		res.Created_by,
		res.Res_title, res.Res_desc, res.Url, isParent, res.Parent_uuid, isStatewide, res.Keyword,
		res.Line_1, res.Line_2, res.City, res.County, res.State, res.Postal_code,
		res.Phone_1, res.Phone_2, res.Phone_tty, res.Fax, res.Email,
		res.Category_id)
	result, err := config.DBConn.Exec(sql)
	if err != nil {
		return result, err
	}
	return result, nil
}

func boolToBit(val bool) uint8 {
	if val {
		return 1
	} else {
		return 0
	}
}
