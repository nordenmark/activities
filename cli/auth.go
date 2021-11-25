package main

import (
	"encoding/json"
)

type AuthService struct {
	api ApiService
}

type LoginResponse struct {
	AccessToken string `json:"accessToken"`
}

// /auth/login
func (service *AuthService) Login(email string, password string) (string, error) {
	payload := map[string]string{"email": email, "password": password}

	jsonResponse, err := service.api.Post("/auth/login", payload)

	if err != nil {
		return "", err
	}

	var response LoginResponse
	json.Unmarshal([]byte(jsonResponse), &response)

	return response.AccessToken, nil
}

func CreateAuthService(api ApiService) *AuthService {
	return &AuthService{api: api}
}
