package main

import (
	"fmt"
)

func main() {
	cards := []string{"A", "K", "Q", "J"}

	for _, card := range cards {
		fmt.Println(card)
	}

	// i declared but not used
	// for i, card := range cards {
	// 	fmt.Println(card)
	// }

}
