package main

import (
	"encoding/json"
	"time"
)

type WorkoutsService struct {
	api ApiService
}

type Workouts []struct {
	Activity string    `json:"activity"`
	Date     time.Time `json:"date"`
}

func (service *WorkoutsService) List(token string, year int) (Workouts, error) {

	jsonResponse, err := service.api.Get("/workouts", token)

	if err != nil {
		return nil, err
	}

	var workouts Workouts
	json.Unmarshal([]byte(jsonResponse), &workouts)

	filteredWorkouts := Workouts{}

	for _, workout := range workouts {
		if workout.Date.Year() == year {
			filteredWorkouts = append(filteredWorkouts, workout)
		}
	}

	return filteredWorkouts, nil
}

func CreateWorkoutsService(api ApiService) *WorkoutsService {
	return &WorkoutsService{api: api}
}
