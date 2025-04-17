package services

import (
	"database/sql"

	"thelocr/api/models"
	"thelocr/api/repositories"
)

type UserService struct{}

var userRepository = new(repositories.UserRepository)

func (us *UserService) GetById(id string) (models.User, error) {
	user, err := userRepository.GetById(id)
	if err != nil {
		return user, err
	}
	return user, nil
}

func (us *UserService) Login(terms models.UserLogin) (models.User, error) {
	user, err := userRepository.Login(terms)
	if err != nil {
		return user, err
	}
	return user, nil
}

func (us *UserService) Create(terms models.UserCreate) (sql.Result, error) {
	result, err := userRepository.Create(terms)
	if err != nil {
		return result, err
	}
	return result, nil
}
