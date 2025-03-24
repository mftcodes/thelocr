package services

import (
	"database/sql"

	"bowen/platform/models"
	"bowen/platform/repositories"
)

type ResourceService struct{}

var resourceRepository = new(repositories.ResourceRepository)

func (rs *ResourceService) Create(res models.ResourceInsert) (sql.Result, error) {
	result, err := resourceRepository.Create(res)
	if err != nil {
		return result, err
	}
	return result, nil
}

func (rs *ResourceService) SearchBase(terms models.ResourceSearchBase) ([]models.ResourceDetail, error) {
	result, err := resourceRepository.SearchBase(terms)
	if err != nil {
		return result, err
	}
	return result, nil
}

func (rs *ResourceService) Update(res models.ResourceEdit) (sql.Result, error) {
	result, err := resourceRepository.Update(res)
	if err != nil {
		return result, err
	}
	return result, nil
}
