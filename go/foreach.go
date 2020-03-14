// https://golang.org/pkg/math/rand/

package main

import (
	"fmt"
)

func main() {

	cards := []string{"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"}
	for i, card := range cards {
		fmt.Println(i, card)
	}

}

// e.g
//
// 0 2
// 1 3
// 2 4
// 3 5
// 4 6
// 5 7
// 6 8
// 7 9
// 8 10
// 9 J
// 10 Q
// 11 K
// 12 A
