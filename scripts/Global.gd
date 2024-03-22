extends Node

var dayTime = false
var lights = true
var coinCollectionSound = false
var coins = 0
@onready var coins_score = $CanvasLayer/Panel/CoinsScore

func addCoins():
	coins += 1
