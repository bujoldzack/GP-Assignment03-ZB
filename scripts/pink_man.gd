extends CharacterBody2D


const SPEED = 250.0
const DOUBLE_JUMP_VELOCITY = -300.0
const JUMP_VELOCITY = -400.0
var walkingSound = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = true
@onready var pinkMan = $AnimatedSprite2D
@onready var cpu_particles_2d = $CPUParticles2D
@onready var point_light_2d = $PointLight2D
@onready var walking_sound = $walkingSound

func animation():
	if velocity.x > 0.5:
		pinkMan.play('run')
		pinkMan.scale.x = 1.5
		cpu_particles_2d.emitting = true
		cpu_particles_2d.scale.x = 1
		walkingSound = true
	elif velocity.x < -0.5:
		pinkMan.play('run')
		pinkMan.scale.x = -1.5
		cpu_particles_2d.emitting = true
		cpu_particles_2d.scale.x = -1
		walkingSound = true
	else:
		pinkMan.play("idle")
		walkingSound = false
		cpu_particles_2d.emitting = false
	
	if Global.lights == false:
		point_light_2d.visible = false
	else:
		point_light_2d.visible = true
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		pinkMan.play('jump')
		
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			can_double_jump = true
		elif can_double_jump:
			velocity.y = DOUBLE_JUMP_VELOCITY
			can_double_jump = false  

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		pinkMan.flip_h
	else:
		velocity.x = move_toward(velocity.x, 0, 35)

	move_and_slide()
	animation()
	
	if walkingSound == true and !walking_sound.playing:
		walking_sound.play()
	elif walkingSound == false and walking_sound.playing:
		walking_sound.stop()
