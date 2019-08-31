extends Sprite

var cards = []

export var deckSize = 60

onready var possibleCards = [
"res://cards/Card.tscn",
"res://cards/Card2.tscn"
]

func _ready():
	randomize()
	for i in range(deckSize):
		cards.append(possibleCards[rand_range(0, possibleCards.size())])

func drawCard():
	var r = rand_range(0, cards.size())
	var ret = createCard(cards[r])
	cards.remove(r)
	return ret

func createCard(path):
	var card = load(path).instance()
	return card