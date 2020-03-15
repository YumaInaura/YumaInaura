package main

// TODO : deal card A as point 1
// TODO : append card by dealer

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"time"
)

// Card : Playing card
type Card struct {
	Point int
	Name  string
}

func main() {
	var playerCards, dealerCards []Card

	stockCards := generateCards()

	shuffleCards(stockCards)

	playerCards, stockCards = dealFirstTwoCards(stockCards)
	dealerCards, stockCards = dealFirstTwoCards(stockCards)

	for range stockCards {
		fmt.Println("Dealer cards are ... ")
		showCards(dealerCards)

		fmt.Println("Your cards are ... ")
		showCards(playerCards)

		playerPoint := cardsPoint(playerCards)
		dealerPoint := cardsPoint(dealerCards)
		fmt.Println("Your point is ... " + strconv.Itoa(playerPoint))

		if playerPoint > 21 {
			fmt.Println("BUST! ")
			break
		}

		playerCommand := waitPlayerCommand()

		if playerCommand == "1" {
			playerCards, stockCards = appendCard(playerCards, stockCards)
		} else {
			if playerPoint >= dealerPoint {
				fmt.Println("YOU WIN!")
				break
			} else {
				fmt.Println("YOU LOSE ...")
				break
			}
		}

		fmt.Println()
	}

	fmt.Println("FINISH GAME")
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
		Card{10, "J"},
		Card{10, "Q"},
		Card{10, "K"},
		Card{11, "A"},
	}
}

func shuffleCards(cards []Card) {
	rand.Seed(time.Now().UnixNano())
	rand.Shuffle(len(cards), func(i, j int) { cards[i], cards[j] = cards[j], cards[i] })
}

func dealFirstTwoCards(stockCards []Card) ([]Card, []Card) {
	var haveCards []Card
	haveCards, stockCards = appendCard(haveCards, stockCards)
	haveCards, stockCards = appendCard(haveCards, stockCards)
	return haveCards, stockCards
}

func showCards(playerCards []Card) {
	for _, playerCard := range playerCards {
		fmt.Println(playerCard.Name)
	}
}

func waitPlayerCommand() string {
	fmt.Println("[1] Append Card")
	fmt.Println("[0] No Change")

	input := bufio.NewScanner(os.Stdin)
	input.Scan()

	command := input.Text()

	return command
}

func cardsPoint(cards []Card) int {
	var point = 0
	for _, Card := range cards {
		point = point + Card.Point
	}
	return point
}

func appendCard(haveCards []Card, stockCards []Card) ([]Card, []Card) {
	var card Card
	card, stockCards = stockCards[0], stockCards[1:]
	haveCards = append(haveCards, card)

	return haveCards, stockCards
}
