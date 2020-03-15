package main

import (
	"fmt"
	"sort"
)

type Card struct {
	Strong int
	Name   string
}

func main() {
	cards := []Card{
		Card{2, "2"},
		Card{3, "3"},
		Card{4, "4"},
		Card{5, "5"},
		Card{6, "6"},
		Card{7, "7"},
		Card{8, "8"},
		Card{9, "9"},
		Card{10, "10"},
		Card{11, "J"},
		Card{12, "Q"},
		Card{13, "K"},
		Card{14, "A"},
	}

	sort.SliceStable(cards, func(i, j int) bool {
		return cards[i].Strong > cards[j].Strong
	})

	fmt.Println(cards)
}

// [{14 A} {13 K} {12 Q} {11 J} {10 10} {9 9} {8 8} {7 7} {6 6} {5 5} {4 4} {3 3} {2 2}]
