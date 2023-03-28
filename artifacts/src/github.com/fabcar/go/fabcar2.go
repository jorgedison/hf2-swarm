package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// Car represents a car with properties.
type Car struct {
	Properties map[string]interface{} `json:"properties"`
}

// CarContract provides functions for managing a Car.
type CarContract struct {
	contractapi.Contract
}

// RegisterCar creates a new Car with the given properties.
func (cc *CarContract) RegisterCar(ctx contractapi.TransactionContextInterface, carJSON string) error {
	// Unmarshal car JSON string into Car struct
	var car Car
	err := json.Unmarshal([]byte(carJSON), &car)
	if err != nil {
		return fmt.Errorf("failed to unmarshal car JSON: %v", err)
	}

	// Store car in world state
	key, err := ctx.GetStub().CreateCompositeKey("Car", []string{})
	if err != nil {
		return fmt.Errorf("failed to create composite key: %v", err)
	}
	carBytes, err := json.Marshal(car)
	if err != nil {
		return fmt.Errorf("failed to marshal car: %v", err)
	}
	err = ctx.GetStub().PutState(key, carBytes)
	if err != nil {
		return fmt.Errorf("failed to put car in world state: %v", err)
	}

	// Return success
	return nil
}

// UpdateCar updates an existing Car with the given properties.
func (cc *CarContract) UpdateCar(ctx contractapi.TransactionContextInterface, carJSON string) error {
	// Unmarshal car JSON string into Car struct
	var car Car
	err := json.Unmarshal([]byte(carJSON), &car)
	if err != nil {
		return fmt.Errorf("failed to unmarshal car JSON: %v", err)
	}

	// Get car from world state
	key, err := ctx.GetStub().CreateCompositeKey("Car", []string{})
	if err != nil {
		return fmt.Errorf("failed to create composite key: %v", err)
	}
	carBytes, err := ctx.GetStub().GetState(key)
	if err != nil {
		return fmt.Errorf("failed to get car from world state: %v", err)
	}
	if carBytes == nil {
		return fmt.Errorf("car does not exist")
	}

	// Unmarshal car from world state
	err = json.Unmarshal(carBytes, &car)
	if err != nil {
		return fmt.Errorf("failed to unmarshal car from world state: %v", err)
	}

	// Update car in world state
	carBytes, err = json.Marshal(car)
	if err != nil {
		return fmt.Errorf("failed to marshal car: %v", err)
	}
	err = ctx.GetStub().PutState(key, carBytes)
	if err != nil {
		return fmt.Errorf("failed to update car in world state: %v", err)
	}

	// Return success
	return nil
}

// GetCar returns the Car with the given ID.
func (cc *CarContract) GetCar(ctx contractapi.TransactionContextInterface) (*Car, error) {
	// Get car from world state
	key, err := ctx.GetStub().CreateCompositeKey("Car", []string{})
	if err != nil {
		return nil, fmt.Errorf("failed to create composite key: %v", err)
	}
	carBytes, err := ctx.GetStub().GetState(key)
	if err != nil {
		return nil, fmt.Errorf("failed to get car from world state: %
