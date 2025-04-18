package services

import (
	"thelocr/api/models"
	"thelocr/api/repositories"
)

type CategoryService struct{}

var categoryRepository = new(repositories.CategoryRepository)

func (cs *CategoryService) GetAll() ([]models.Category, error) {
	cats, err := categoryRepository.GetAll()
	if err != nil {
		return cats, err
	}
	return cats, nil
}
