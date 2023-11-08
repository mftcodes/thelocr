package services

import (
	"bowen/models"
	"bowen/repositories"
)

type AddressService struct{}

var addressRepository = new(repositories.AddressRepository)

func (as *AddressService) GetById(id string) (models.Address, error) {
	addr, err := addressRepository.GetById(id)
	if err != nil {
		return addr, err
	}
	return addr, nil
}

func (as *AddressService) GetAll() ([]models.Address, error) {
	addrs, err := addressRepository.GetAll()
	if err != nil {
		return addrs, err
	}
	return addrs, nil
}

func (as *AddressService) Create() {

}

func (as *AddressService) Update() {

}

func (as *AddressService) Delete() {

}
