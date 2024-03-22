extends Node

@onready var directional_light_2d = $DirectionalLight2D
@onready var daytime = $Daytime
@onready var coin_collection_sound = $CoinCollectionSound
@onready var background = $Background
@onready var coins_score = $CanvasLayer/Panel/CoinsScore
@onready var flicker_timer = $FlickerTimer
@onready var gpu_particles_2d = $Particules/GPUParticles2D
@onready var thunder_sound = $ThunderSound
@onready var death_sound = $"DeathSpot/Death Sound"
@onready var win_screen = $WinScreen


var original_energy = 0.0
var max_energy = 1.5
var min_energy = 1.0
var flicker_speed = 6.0
var flicker_duration = 0.5
var is_flickering = false
var original_color = Color(0.71, 0.765, 0.663)
var flicker_color = Color(0.814, 0.747, 0.41)
var spawn_position = Vector2(100, 500)

# Called when the node enters the scene tree for the first time.
func _ready():
	original_energy = directional_light_2d.energy
	original_color = directional_light_2d.color

# Called everyframe. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.dayTime == true:
		directional_light_2d.visible = false
		gpu_particles_2d.emitting = false
		Global.lights = false
		Global.dayTime = false
		daytime.start()
		
		if Global.coinCollectionSound == true:
			coin_collection_sound.playing = true
		
		if background.playing == false:
			background.play()
			
		coins_score.text = ' Coins: ' + str(Global.coins)
	
	if is_flickering:
		var energy_delta = flicker_speed * delta
		directional_light_2d.energy += energy_delta
		if directional_light_2d.energy >= max_energy or directional_light_2d.energy <= min_energy:
			flicker_speed *= -1
			
	if Global.coins == 10:
		win_screen.visible = true
		get_tree().paused = true

func _on_daytime_timeout():
	Global.lights = true
	gpu_particles_2d.emitting = true
	directional_light_2d.visible = true

func _on_big_area_body_entered(body):
	if body.name == 'PinkMan':
		body.position = spawn_position
		death_sound.play()

func _on_small_area_body_entered(body):
	if body.name == 'PinkMan':
		body.position = spawn_position
		death_sound.play()

func _on_thunder_timeout():
	if not is_flickering:
		is_flickering = true
		start_flicker()

func start_flicker():
	flicker_timer.one_shot = true
	flicker_timer.wait_time = flicker_duration
	flicker_timer.start()
	if Global.lights == true:
		thunder_sound.play()
	directional_light_2d.color = flicker_color

func _on_flicker_timer_timeout():
	is_flickering = false
	directional_light_2d.energy = original_energy
	directional_light_2d.color = original_color 
