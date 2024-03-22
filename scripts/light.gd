extends Node2D

@onready var point_light_2d = $PointLight2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var cpu_particles_2d = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.lights == false:
		point_light_2d.visible = false
		cpu_particles_2d.emitting = false
		animated_sprite_2d.play("off")
	else:
		point_light_2d.visible = true
		cpu_particles_2d.emitting = true
		animated_sprite_2d.play("default")
