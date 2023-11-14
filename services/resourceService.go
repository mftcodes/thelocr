package services

import (
	"database/sql"

	"bowen/models"
	"bowen/repositories"
)

type ResourceService struct{}

var resourceRepository = new(repositories.ResourceRepository)

func (rs *ResourceService) Get() {

}

func (rs *ResourceService) GetAll() {

}

func (rs *ResourceService) Create(res models.ResourceInsert) (sql.Result, error) {
	result, err := resourceRepository.Create(res)
	if err != nil {
		return result, err
	}
	return result, nil
}

func (rs *ResourceService) Update() {

}

func (rs *ResourceService) Delete() {

}

func (rs *ResourceService) SearchBase(terms models.ResourceSearchBase) ([]models.ResourceDetail, error) {
	result, err := resourceRepository.SearchBase(terms)
	if err != nil {
		return result, err
	}
	return result, nil
}
