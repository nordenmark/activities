package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
)

type ApiService struct {
	config Config
	cache  CacheService
}

func (service *ApiService) Get(endpoint string, token string) (string, error) {
	// Attempt to read from cache
	if cached := service.cache.Get(endpoint); cached != "" {
		return cached, nil
	}

	client := http.Client{}

	host := fmt.Sprintf("%v%v", service.config.apiHost, endpoint)

	req, err := http.NewRequest("GET", host, nil)
	if err != nil {
		return "", err
	}

	req.Header = http.Header{
		"Authorization": []string{fmt.Sprintf("Bearer %s", token)},
	}

	resp, err := client.Do(req)

	if resp.StatusCode >= 300 {
		return "", errors.New(resp.Status)
	}

	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	// Convert the body to type string
	stringBody := string(body)

	// Update the cache
	service.cache.Set(endpoint, stringBody)

	return stringBody, nil
}

func (service *ApiService) Post(endpoint string, payload map[string]string) (string, error) {
	host := fmt.Sprintf("%v%v", service.config.apiHost, endpoint)

	postBody, _ := json.Marshal(payload)

	resp, err := http.Post(host, "application/json", bytes.NewBuffer(postBody))
	if err != nil {
		return "", err
	}

	defer resp.Body.Close()

	if resp.StatusCode >= 300 {
		return "", errors.New(resp.Status)
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	return string(body), nil
}

func CreateApiService(config Config, cache CacheService) *ApiService {
	return &ApiService{config: config, cache: cache}
}
