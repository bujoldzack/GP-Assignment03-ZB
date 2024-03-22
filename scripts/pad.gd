extends Node2D
@onready var animated_sprite_2d = $StaticBody/AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer

const jumpVelocity = -1000

func _on_area_2d_body_entered(body):
	if body.name == 'PinkMan':
		body.velocity.y = jumpVelocity
		animated_sprite_2d.play("jump")
		audio_stream_player.play()
