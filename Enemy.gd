extends CharacterBody3D

const speed_scale = 0.1
var PL
var HP = 100
const JUMP_VELOCITY = 5.0 * 2
var jumping = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	set_deferred("disabled", false)
	add_to_group("enemies")

func _physics_process(delta):

	if jumping or not is_on_floor():
		if jumping:
			velocity.y = JUMP_VELOCITY
			jumping = false
		else:
			velocity.y -= gravity * delta * 4
		velocity.x *= -1
		velocity.z *= -1
	else:
		velocity = (PL.position - position).normalized() * speed_scale / delta

	move_and_slide()

func initialize(start_position, player):
	PL = player
	look_at_from_position(start_position, PL.position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	scale = Vector3(0.5, 0.5, 0.5)

func hit():
	# TODO: by who, damage etc
	jumping = true
	HP -= 50
	print('hit ', HP)

func isDead():
	return HP <= 0

