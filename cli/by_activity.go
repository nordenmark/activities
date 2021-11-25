package main

import (
	"sort"

	"github.com/fatih/color"
	"github.com/rodaine/table"
)

type Activity struct {
	title string
	count int
}

func getActivitiesOrderByCount(workouts Workouts) []Activity {
	countMap := getCountPerActivity(workouts)
	activities := []Activity{}

	for activity, count := range countMap {
		activities = append(activities, Activity{activity, count})
	}

	sort.SliceStable(activities, func(i, j int) bool {
		return activities[i].count > activities[j].count
	})

	return activities
}

func getCountPerActivity(workouts Workouts) map[string]int {
	countMap := map[string]int{}

	for _, workout := range workouts {
		count, ok := countMap[workout.Activity]

		if !ok {
			countMap[workout.Activity] = 0
		}

		countMap[workout.Activity] = count + 1
	}

	return countMap
}

func ByActivity(workouts Workouts) {
	headerFmt := color.New(color.FgGreen, color.Underline).SprintfFunc()
	columnFmt := color.New(color.FgYellow).SprintfFunc()

	tbl := table.New("Activity", "Count")
	tbl.WithHeaderFormatter(headerFmt).WithFirstColumnFormatter(columnFmt)

	// Sort the values so we can print the activities in descending order
	activities := getActivitiesOrderByCount(workouts)

	for _, activity := range activities {
		tbl.AddRow(activity.title, activity.count)
	}

	tbl.Print()
}
