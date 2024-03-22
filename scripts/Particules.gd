extends Node2D
@onready var gpu_particles_2d_2 = $GPUParticles2D2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()
	gpu_particles_2d_2.position.x = top_left.x + size.x/2
	gpu_particles_2d_2.position.y = top_left.y + 50
	gpu_particles_2d_2.get_process_material().set_emission_box_extents(Vector3(size.x, 50, 1))
	
