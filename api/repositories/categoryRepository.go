package repositories

import (
	"thelocr/api/config"
	"thelocr/api/models"
)

type CategoryRepository struct {
}

func (cr *CategoryRepository) GetAll() ([]models.Category, error) {
	var cats []models.Category

	sql := `
		SELECT * 
		  FROM category 
		 ORDER BY cat_title;
	`
	rows, err := config.DBConn.Query(sql)
	if err != nil {
		return cats, err
	}
	defer rows.Close()

	for rows.Next() {
		var cat models.Category
		err := rows.Scan(&cat.Cat_id, &cat.Cat_title, &cat.Cat_desc, &cat.Created, &cat.Created_by, &cat.Modified, &cat.Modified_by)
		if err != nil {
			panic(err)
		}
		cats = append(cats, cat)
	}

	return cats, nil
}
