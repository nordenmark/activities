package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"time"

	_ "github.com/joho/godotenv/autoload"
)

type Config struct {
	email     string
	password  string
	apiHost   string
	cacheRoot string
	cacheTTL  int
	year      int
}

func getConfig() Config {
	return Config{
		email:     os.Getenv("LOGIN_EMAIL"),
		password:  os.Getenv("LOGIN_PASSWORD"),
		apiHost:   os.Getenv("API_HOST"),
		cacheRoot: "/tmp/workouts",
		cacheTTL:  10,
	}
}

func main() {
	var config Config = getConfig()

	flag.IntVar(&config.year, "year", time.Now().Year(), "year to fetch workouts for")
	flag.Parse()

	cacheService := CreateCacheService(config.cacheRoot, config.cacheTTL)
	apiService := CreateApiService(config, *cacheService)
	authService := CreateAuthService(*apiService)
	workoutsService := CreateWorkoutsService(*apiService)

	fmt.Println(fmt.Sprintf("** Running with email: [%s] and apiHost: [%s]", config.email, config.apiHost))

	token, err := authService.Login(config.email, config.password)

	if err != nil {
		log.Fatalf("Login failed with error [%s]", err)
	}

	workouts, err := workoutsService.List(token, config.year)

	Monthly(workouts)
	ByActivity(workouts)
}
