// https://golang.org/pkg/math/rand/

package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	for {
		fmt.Println("Enter some words!")
		input := bufio.NewScanner(os.Stdin)
		input.Scan()
		fmt.Println("input is " + input.Text())
	}
}

// Enter some words!
// A
// input is A
// Enter some words!
// B
// input is B
// Enter some words!
// C
// input is C
// Enter some words!
