package repositories

import (
	"database/sql"
	"fmt"

	"thelocr/api/config"
	"thelocr/api/models"
)

type ResourceRepository struct{}

func (rr *ResourceRepository) GetById(id string) (models.ResourceDetail, error) {
	var resDetail models.ResourceDetail
	sql := fmt.Sprintf(`
	SELECT r.res_uuid, r.res_title, r.res_desc, r.url, a.addr_uuid, 
		a.line_1, a.line_2, a.line_3, a.city, a.county, a.state, a.postal_code, c.con_uuid, 
		c.phone_1, c.phone_2, c.phone_tty, c.fax, c.email
	FROM minuchin.resource as r
		JOIN minuchin.detail as d on r.res_uuid = d.res_uuid
		JOIN minuchin.address as a on d.addr_uuid = a.addr_uuid
		JOIN minuchin.contact as c on d.con_uuid = c.con_uuid
		JOIN minuchin.classification as cl on r.res_uuid = cl.res_uuid
		RIGHT JOIN minuchin.category as ct on cl.cat_id = ct.cat_id
	WHERE r.res_uuid = '%s'`, id)

	rows, err := config.DBConn.Query(sql)
	if err != nil {
		return resDetail, err
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&resDetail.Res_uuid, &resDetail.Res_title, &resDetail.Res_desc, &resDetail.Url, &resDetail.Addr_uuid, &resDetail.Line_1, &resDetail.Line_2, &resDetail.Line_3, &resDetail.City, &resDetail.County, &resDetail.State, &resDetail.Postal_code, &resDetail.Con_uuid, &resDetail.Phone_1, &resDetail.Phone_2, &resDetail.Phone_tty, &resDetail.Fax, &resDetail.Email)
		if err != nil {
			return resDetail, err
		}
	}

	return resDetail, nil
}

func (rr *ResourceRepository) Create(res models.ResourceInsert) (string, error) {
	var uuid string
	isParent := boolToBit(res.Is_parent)
	isStatewide := boolToBit(res.Is_statewide)

	sql := fmt.Sprintf(`
	CALL minuchin.sp_insertResource(%v,%v,%v,%v,%d,%v,%d,%v,%v,%v,%v,%v,%v,%v,%v,%v,%v,%v,%v,%d)`,
		sqlNullStrToStr(res.Created_by),
		sqlNullStrToStr(res.Res_title),
		sqlNullStrToStr(res.Res_desc),
		sqlNullStrToStr(res.Url),
		isParent,
		sqlNullStrToStr(res.Parent_uuid),
		isStatewide,
		sqlNullStrToStr(res.Keyword),
		sqlNullStrToStr(res.Line_1),
		sqlNullStrToStr(res.Line_2),
		sqlNullStrToStr(res.City),
		sqlNullStrToStr(res.County),
		sqlNullStrToStr(res.State),
		sqlNullStrToStr(res.Postal_code),
		sqlNullStrToStr(res.Phone_1),
		sqlNullStrToStr(res.Phone_2),
		sqlNullStrToStr(res.Phone_tty),
		sqlNullStrToStr(res.Fax),
		sqlNullStrToStr(res.Email),
		res.Cat_id)

	rows, err := config.DBConn.Query(sql)
	if err != nil {
		return uuid, err
	}
	defer rows.Close()

	for rows.Next() {
		var _uuid string
		err := rows.Scan(&_uuid)
		if err != nil {
			return uuid, err
		}
		uuid = _uuid
	}

	return uuid, nil
}

func (rr *ResourceRepository) SearchBase(terms models.ResourceSearchBase) ([]models.ResourceDetail, error) {
	var resDetails []models.ResourceDetail
	isStatewide := boolToBit(terms.Is_statewide)

	sql := fmt.Sprintf(`
	CALL minuchin.sp_searchResourceBase(%d, '%s', '%s', %d);
	`, isStatewide, terms.County, terms.State, terms.Cat_id)

	rows, err := config.DBConn.Query(sql)
	if err != nil {
		return resDetails, err
	}
	defer rows.Close()

	for rows.Next() {
		var resDet models.ResourceDetail
		err := rows.Scan(&resDet.Res_uuid, &resDet.Res_title, &resDet.Res_desc, &resDet.Url, &resDet.Addr_uuid, &resDet.Line_1, &resDet.Line_2, &resDet.Line_3, &resDet.City, &resDet.County, &resDet.State, &resDet.Postal_code, &resDet.Con_uuid, &resDet.Phone_1, &resDet.Phone_2, &resDet.Phone_tty, &resDet.Fax, &resDet.Email)
		if err != nil {
			return resDetails, err
		}
		resDetails = append(resDetails, resDet)
	}

	return resDetails, nil
}

/* SProc Structure
 *	CALL minuchin.sp_updateFullResource(
 * 	:addrUuid, :line1, :line2, :line3, :city, :county, :state, :postalCode,
 *	:conUuid, :phone1, :phone2, :phoneTty, :fax, :email,
 *	:resUuid, :resTitle, :resDesc, :url, :isParent, :parentUuid, :isStatewide, :isNationwide, :keyword,
 *	:modified, :modifiedBy);
 */
func (rr *ResourceRepository) Update(res models.ResourceEdit) (sql.Result, error) {
	sql := fmt.Sprintf(`
	CALL minuchin.sp_updateFullResource(
		'%s', %s, %s, %s, %s, %s, %s, %s, 
		'%s', %s, %s, %s, %s, %s, 
		'%s', %s, %s, %s, %d, %s, %d, %d, %s, 
		null, %s);`,
		res.Address.Addr_uuid,
		sqlNullStrToStr(res.Address.Line_1),
		sqlNullStrToStr(res.Address.Line_2),
		sqlNullStrToStr(res.Address.Line_3),
		sqlNullStrToStr(res.Address.City),
		sqlNullStrToStr(res.Address.County),
		sqlNullStrToStr(res.Address.State),
		sqlNullStrToStr(res.Address.Postal_code),
		res.Contact.Con_uuid,
		sqlNullStrToStr(res.Contact.Phone_1),
		sqlNullStrToStr(res.Contact.Phone_2),
		sqlNullStrToStr(res.Contact.Phone_tty),
		sqlNullStrToStr(res.Contact.Fax),
		sqlNullStrToStr(res.Contact.Email),
		res.Resource.Res_uuid,
		sqlNullStrToStr(res.Resource.Res_title),
		sqlNullStrToStr(res.Resource.Res_desc),
		sqlNullStrToStr(res.Resource.Url),
		boolToBit(res.Resource.Is_parent),
		sqlNullStrToStr(res.Resource.Parent_uuid),
		boolToBit(res.Resource.Is_statewide),
		boolToBit(res.Resource.Is_nationwide),
		sqlNullStrToStr(res.Resource.Keyword),
		sqlNullStrToStr(res.Resource.Modified_by))
	result, err := config.DBConn.Exec(sql)
	if err != nil {
		return result, err
	}
	return result, nil
}
