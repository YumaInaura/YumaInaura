package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"time"
)

type Card struct {
	Strong int
	Name   string
}

func main() {
	var playerCards []Card

	cards := generateCards()

	shuffleCards(cards)

	playerCards, cards = dealFirstTwoCards(cards)

	for range cards {
		playerCommand := waitPlayerCommand(cards, playerCards)

		if playerCommand == "1" {
			playerCards, cards = appendCard(playerCards, cards)
		} else {
		}

		fmt.Println()
	}
}

func generateCards() []Card {
	cards := []Card{}
	cardSeeds := cardSeeds()

	for i := 0; i < 4; i++ {
		cards = append(cards, cardSeeds...)
	}
	return cards
}

func cardSeeds() []Card {
	return []Card{
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
}

func shuffleCards(cards []Card) {
	rand.Seed(time.Now().UnixNano())
	rand.Shuffle(len(cards), func(i, j int) { cards[i], cards[j] = cards[j], cards[i] })
}

func dealFirstTwoCards(cards []Card) ([]Card, []Card) {
	var haveCards []Card
	haveCards, cards = appendCard(haveCards, cards)
	haveCards, cards = appendCard(haveCards, cards)
	return haveCards, cards
}

func waitPlayerCommand(cards []Card, playerCards []Card) string {
	fmt.Println("Your cards are ... ")
	for _, card := range playerCards {
		fmt.Println(card.Name)
	}

	fmt.Println("[0] No Change")
	fmt.Println("[1] Append Card")

	input := bufio.NewScanner(os.Stdin)
	input.Scan()

	command := input.Text()

	return command
}

func appendCard(haveCards []Card, stockCards []Card) ([]Card, []Card) {
	var card Card
	card, stockCards = stockCards[0], stockCards[1:]
	haveCards = append(haveCards, card)

	return haveCards, stockCards
}
