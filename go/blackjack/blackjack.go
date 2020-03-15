package main

// TODO : Dealer BUST pattern

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"sort"
	"strconv"
	"time"
)

const BlackJackPoint = 21

// Card : Playing card
type Card struct {
	Points []int
	Name   string
}

// FIXME: complexed GAME flow
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

		playerCommand := waitPlayerCommand()

		// Player HIT
		if playerCommand == "1" {
			playerCards, stockCards = appendCard(playerCards, stockCards)
		}

		if dealerPoint < 17 {
			dealerCards, stockCards = appendCard(dealerCards, stockCards)
			fmt.Println("Dealer HIT")
			fmt.Println("Dealer cards are ... ")
			showCards(dealerCards)
		} else {
			fmt.Println("Dealer STAND")
		}

		playerPoint = cardsPoint(playerCards)
		dealerPoint = cardsPoint(dealerCards)

		if playerPoint > BlackJackPoint {
			fmt.Println("BUST! ")
			break
		}

		if playerPoint == BlackJackPoint {
			fmt.Println("BLACK JACK! YOU WIN!")
			break
		}

		// Player STAND
		if playerCommand != "1" {
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
		Card{[]int{2}, "2"},
		Card{[]int{3}, "3"},
		Card{[]int{4}, "4"},
		Card{[]int{5}, "5"},
		Card{[]int{6}, "6"},
		Card{[]int{7}, "7"},
		Card{[]int{8}, "8"},
		Card{[]int{9}, "9"},
		Card{[]int{10}, "10"},
		Card{[]int{10}, "J"},
		Card{[]int{10}, "Q"},
		Card{[]int{10}, "K"},
		Card{[]int{11, 1}, "A"},
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
	fmt.Println("[1] Hit")
	fmt.Println("[0] Stand")

	input := bufio.NewScanner(os.Stdin)
	input.Scan()

	command := input.Text()

	return command
}

func cardsPoint(cards []Card) int {
	var point = 0

	// For Evaluate Card "A" after all other cards
	sort.SliceStable(cards, func(i, j int) bool {
		return cards[i].Points[0] < cards[j].Points[0]
	})

	for _, card := range cards {
		// Treat point 1 when Card A and prevent BUST
		if card.Points[0]+point > BlackJackPoint && len(card.Points) == 2 {
			point = point + card.Points[1]
		} else {
			point = point + card.Points[0]
		}
	}
	return point
}

func appendCard(haveCards []Card, stockCards []Card) ([]Card, []Card) {
	var card Card
	card, stockCards = stockCards[0], stockCards[1:]
	haveCards = append(haveCards, card)

	return haveCards, stockCards
}
