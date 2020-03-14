package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"time"
)

type Card struct {
	number int
	name   string
}

func main() {
	var yourCards []string

	cards := generateCards()

	shuffleCards(cards)

	yourCards, cards = dealFirstTwoCards(cards)

	for range cards {
		playerCommand := waitPlayerCommand(cards, yourCards)

		if playerCommand == "1" {
			yourCards, cards = swapCard(yourCards, 0, cards)
		} else if playerCommand == "2" {
			yourCards, cards = swapCard(yourCards, 1, cards)
		} else if playerCommand == "0" {
		}

		fmt.Println()
	}
}

func generateCards() []string {
	cardSeeds := []string{"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"}
	cards := []string{}

	for i := 0; i < 4; i++ {
		cards = append(cards, cardSeeds...)
	}
	return cards
}

func shuffleCards(cards []string) {
	rand.Seed(time.Now().UnixNano())
	rand.Shuffle(len(cards), func(i, j int) { cards[i], cards[j] = cards[j], cards[i] })
}

func dealFirstTwoCards(cards []string) ([]string, []string) {
	haveCards := []string{}
	for i := 0; i < 2; i++ {
		var card string
		card, cards = cards[0], cards[1:]
		haveCards = append(haveCards, card)
	}

	return haveCards, cards
}

func waitPlayerCommand(cards []string, yourCards []string) string {
	fmt.Println("Left cards num is ...")
	fmt.Println(len(cards))
	fmt.Println("Your cards are ... ")
	fmt.Println(yourCards)

	fmt.Println("[0] No Change")
	fmt.Println("[1] Swap Left Card")
	fmt.Println("[2] Swap Right Card")

	input := bufio.NewScanner(os.Stdin)
	input.Scan()

	command := input.Text()

	return command
}

func swapCard(haveCards []string, swapNumber int, stockCards []string) ([]string, []string) {
	var card string
	card, stockCards = stockCards[0], stockCards[1:]
	haveCards[swapNumber] = card

	return haveCards, stockCards
}
