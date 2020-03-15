// e.g
//
// dlv debug go/dlv/main.go
//
// (dlv) break main.go:10
// (dlv) break foo:2
// (dlv) break foo:2

package main

import (
	"fmt"
)

func main() {
	fmt.Println("A")
	fmt.Println("B")
	fmt.Println("C")
	fmt.Println("D")
	fmt.Println("E")

	foo()
}

func foo() {
	value := "FOO"
	fmt.Println(value)
}
