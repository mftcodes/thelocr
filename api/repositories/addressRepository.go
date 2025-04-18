package repositories

import (
	"fmt"

	"thelocr/api/config"
	"thelocr/api/models"
)

type AddressRepository struct {
}

func (ar *AddressRepository) GetById(id string) (models.Address, error) {
	var addr models.Address

	sql := fmt.Sprintf(`
		SELECT * 
		  FROM address 
		 WHERE addr_id = %s;
	`, id)
	rows, err := config.DBConn.Query(sql)
	if err != nil {
		return addr, err
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&addr.Addr_id, &addr.Addr_uuid, &addr.Line_1, &addr.Line_2, &addr.Line_3, &addr.City, &addr.County, &addr.State, &addr.Postal_code, &addr.Created, &addr.Created_by, &addr.Modified, &addr.Modified_by)
		if err != nil {
			return addr, err
		}
	}

	return addr, nil
}

func (ar *AddressRepository) GetAll() ([]models.Address, error) {
	var addrs []models.Address

	sql := `
		SELECT * 
		  FROM address 
		 ORDER BY addr_id;
	`
	rows, err := config.DBConn.Query(sql)
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var addr models.Address
		err := rows.Scan(&addr.Addr_id, &addr.Addr_uuid, &addr.Line_1, &addr.Line_2, &addr.Line_3, &addr.City, &addr.County, &addr.State, &addr.Postal_code, &addr.Created, &addr.Created_by, &addr.Modified, &addr.Modified_by)
		if err != nil {
			panic(err)
		}
		addrs = append(addrs, addr)
	}

	return addrs, nil
}
