package main

import "fmt"

type Card struct {
	Names []string
}

func main() {
	card := Card{[]string{"Ace", "Jack", "King"}}

	fmt.Println(card.Names[0]) // Ace
	fmt.Println(card.Names[1]) // Jack
	fmt.Println(card.Names[2]) // King
}
