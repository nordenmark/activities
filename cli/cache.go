package main

import (
	"crypto/md5"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"
)

type CacheService struct {
	cacheRoot string
	ttl       int
}

func getFileAgeInSeconds(filename string) int {
	fileInfo, err := os.Stat(filename)

	if err != nil {
		return 0
	}

	diff := time.Now().Sub(fileInfo.ModTime())

	return int(diff.Seconds())
}

func (service *CacheService) Set(key string, data string) (string, error) {
	hash := md5.Sum([]byte(key))
	filename := fmt.Sprintf("%v/%x.cache", service.cacheRoot, hash)

	log.Printf("Setting cache, key: %s (path: %s)", key, filename)

	err := ioutil.WriteFile(filename, []byte(data), 0777)

	if err != nil {
		log.Printf("Failed to write cache. Key: %s (path: %s)", key, filename)
		return "", err
	}

	return "", nil
}

func (service *CacheService) Get(key string) string {
	hash := md5.Sum([]byte(key))
	filename := fmt.Sprintf("%v/%x.cache", service.cacheRoot, hash)
	data, err := ioutil.ReadFile(filename)

	if err != nil {
		log.Printf("Cache MISS, key: %s (path: %s)", key, filename)
		return ""
	}

	age := getFileAgeInSeconds(filename)

	if age > service.ttl {
		log.Printf("Cache TOO OLD, purging key: %s (age: %ds)", key, age)
		os.Remove(filename)
		return ""
	}

	log.Printf("Cache HIT, key: %s (path: %s, age: %ds)", key, filename, age)

	return string(data)
}

func CreateCacheService(cacheRoot string, ttl int) *CacheService {
	_, err := os.ReadDir(cacheRoot)

	if err != nil {
		log.Println("Will create", cacheRoot)
		os.Mkdir(cacheRoot, 0777)
	}

	return &CacheService{cacheRoot: cacheRoot, ttl: ttl}
}
