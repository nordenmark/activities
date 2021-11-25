package main

import (
	"time"

	"github.com/fatih/color"
	"github.com/rodaine/table"
)

func getCountPerMonth(workouts Workouts) map[int]int {
	countMap := map[int]int{}

	for i := 1; i <= 12; i++ {
		countMap[i] = 0
	}

	for _, workout := range workouts {
		month := int(workout.Date.Month())

		countMap[month] = countMap[month] + 1
	}

	return countMap
}

func readableMonth(month int) string {
	monthMap := map[int]string{
		1:  "January",
		2:  "February",
		3:  "March",
		4:  "April",
		5:  "May",
		6:  "June",
		7:  "July",
		8:  "August",
		9:  "September",
		10: "October",
		11: "November",
		12: "December",
	}

	return monthMap[month]
}

func Monthly(workouts Workouts) {
	countMap := getCountPerMonth(workouts)
	monthsElapsed := int(time.Now().Month())
	averagePerMonth := len(workouts) / monthsElapsed

	headerFmt := color.New(color.FgGreen, color.Underline).SprintfFunc()
	columnFmt := color.New(color.FgYellow).SprintfFunc()

	positiveFmt := color.New(color.FgGreen, color.Bold).SprintFunc()
	negativeFmt := color.New(color.FgRed, color.Bold).SprintFunc()

	tbl := table.New("Month", "Count", "Average per month")
	tbl.WithHeaderFormatter(headerFmt).WithFirstColumnFormatter(columnFmt)

	for month := 1; month <= 12; month++ {
		count, _ := countMap[month]
		label := readableMonth(month)
		if count < averagePerMonth {
			tbl.AddRow(label, negativeFmt(count))
		} else {
			tbl.AddRow(label, positiveFmt(count))
		}
	}

	// Add summary row
	tbl.AddRow("Total", len(workouts), averagePerMonth)

	tbl.Print()
}
