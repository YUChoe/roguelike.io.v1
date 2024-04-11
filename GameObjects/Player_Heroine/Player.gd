extends CharacterBody3D

const SPEED = 7.5
const JUMP_VELOCITY = 5.0
@export var EXP: int = 0
@export var LEVEL:int = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * 2
	
	if Input.is_action_pressed("rotate_left"):		
		rotate_y(-1 * 90 / 16 * delta)		
	if  Input.is_action_pressed("rotate_right"):
		rotate_y(90 / 16 * delta)
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# TODO: rotate with A, D
	# follow camera

	move_and_slide()


#func rotation(rotate_x: bool, key: String, angle: int):
	#if rotate_x:
		#if Input.is_action_pressed(key):
			#current.x = angle
			#rotate_x(angle)
	#else:
		#if Input.is_action_pressed(key):
			#current.y = angle
			#rotate_y(angle)

#func rotating():
	#rotation(true, "ui_right", 90)
	#rotation(false, "ui_left", -90)
	
	#rotation(true, "ui_right", 90)
	#rotation(false, "ui_left", -90)
	#rotation(true, "Up", 90)
	#rotation(false, "Down", -90)



func gainExp(value):
	EXP += value
	# TODO: levelup
