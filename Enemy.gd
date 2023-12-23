extends CharacterBody3D

const speed_scale = 0.1
var PL
var HP = 100

func _ready(): 
	set_deferred("disabled", false)
	add_to_group("enemies")
	
func _physics_process(delta): 
	velocity = (PL.position - position).normalized() * speed_scale / delta
	move_and_slide()
	
func initialize(start_position, player):
	PL = player
	look_at_from_position(start_position, PL.position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))

func hit():
	# TODO: by who, damage etc
	HP -= 50
	print('hit ', HP)
	
func isDead():
	return HP <= 0
	
