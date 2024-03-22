extends Node2D

const MOVEMENT_SPEED = 50
const MAX_HEIGHT = 70

var direction = 1
var initial_position: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector2(0, direction * MOVEMENT_SPEED * delta)
	move_platform(movement)
	
	if abs(position.y - initial_position.y) >= MAX_HEIGHT:
		direction *= -1
	elif position.y == initial_position.y and direction == -1:
		direction = 1
	
func move_platform(movement):
	position += movement
