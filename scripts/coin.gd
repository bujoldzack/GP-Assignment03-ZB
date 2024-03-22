extends Node2D

@onready var coin_collection_sound = $CoinCollectionSound
@onready var coin_sound = $CoinSound

func _on_area_2d_body_entered(body):
	if body.name == 'PinkMan':
		Global.dayTime = true
		Global.coinCollectionSound = true
		Global.addCoins()
		queue_free()

func _process(delta):
	if coin_sound.playing == false:
		coin_sound.play()

