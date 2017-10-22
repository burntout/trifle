package main

import (
	"fmt"
	"time"
)

func main() {
	const shortForm = "2006-Jan-02"
	startDate, _ := time.Parse(shortForm, "1600-Jan-13")
	endDate, _ := time.Parse(shortForm, "2000-Jan-01")
	// an array to hold the count of days in
	var count_days [7]int
	for d := startDate; d.Before(endDate); d = d.AddDate(0, 1, 0) {
		count_days[d.Weekday()]++
	}
	fmt.Println(count_days)
}
