package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// MyContract define la estructura del contrato
type MyContract struct {
	contractapi.Contract
}

// PutData guarda los datos en la ledger
func (mc *MyContract) PutData(ctx contractapi.TransactionContextInterface, key string, value interface{}) error {
	dataBytes, err := json.Marshal(value)
	if err != nil {
		return fmt.Errorf("error al convertir los datos a bytes: %v", err)
	}
	err = ctx.GetStub().PutState(key, dataBytes)
	if err != nil {
		return fmt.Errorf("error al guardar los datos en la ledger: %v", err)
	}
	return nil
}

// GetData recupera los datos de la ledger
func (mc *MyContract) GetData(ctx contractapi.TransactionContextInterface, key string) (interface{}, error) {
	dataBytes, err := ctx.GetStub().GetState(key)
	if err != nil {
		return nil, fmt.Errorf("error al recuperar los datos de la ledger: %v", err)
	}
	var value interface{}
	err = json.Unmarshal(dataBytes, &value)
	if err != nil {
		return nil, fmt.Errorf("error al convertir los datos de bytes a struct: %v", err)
	}
	return value, nil
}

// GetHistoryForKey obtiene el historial de cambios para una clave
func (mc *MyContract) GetHistoryForKey(ctx contractapi.TransactionContextInterface, key string) ([]*contractapi.KeyModification, error) {
	resultsIterator, err := ctx.GetStub().GetHistoryForKey(key)
	if err != nil {
		return nil, fmt.Errorf("error al obtener el historial de cambios para la clave %s: %v", key, err)
	}
	defer resultsIterator.Close()

	var keyModifications []*contractapi.KeyModification
	for resultsIterator.HasNext() {
		modification, err := resultsIterator.Next()
		if err != nil {
			return nil, fmt.Errorf("error al obtener la siguiente modificación para la clave %s: %v", key, err)
		}
		keyModifications = append(keyModifications, modification)
	}
	return keyModifications, nil
}

func main() {
	chaincode, err := contractapi.NewChaincode(&MyContract{})
	if err != nil {
		fmt.Printf("Error al crear el chaincode: %v\n", err)
		return
	}
	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error al iniciar el chaincode: %v\n", err)
	}
}
