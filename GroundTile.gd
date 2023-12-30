extends CSGBox3D

@export var enemy_scene: PackedScene
var PL
var ENMY

const randfactor = 15
const distance_limit = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	PL = get_parent().get_node("Player")
	ENMY = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func checkDistanceLimit(enemy_distance:Vector3):
	if enemy_distance.x >= 0 and enemy_distance.x < distance_limit: return false
	if enemy_distance.x <= 0 and enemy_distance.x > -1 * distance_limit: return false
	if enemy_distance.z >= 0 and enemy_distance.z < distance_limit: return false
	if enemy_distance.z <= 0 and enemy_distance.z > -1 * distance_limit: return false
	return true

func spawn(enemy_distance):
	var newEnemy = enemy_scene.instantiate()

	# enemy_distance = enemy_distance.normalized()  # normallize 하면 방향만 남나?
	newEnemy.global_position = PL.position + enemy_distance
	newEnemy.initialize(enemy_distance, PL)
	add_child(newEnemy)
	ENMY.append(newEnemy)
	# print("ENMY", ENMY.size())
	return true

func _on_timer_timeout():
	while(true):
		var enemy_distance = Vector3(randf_range(-1 * randfactor, randfactor), PL.position.y, randf_range(-1 * randfactor, randfactor))
		if checkDistanceLimit(enemy_distance):
			spawn(enemy_distance)
			break

func get_dist_between_player(e):
	var epos = e.global_position
	return PL.global_position.distance_to(epos)

func _on_melee_attack_timer_timeout():
	#var plpos = PL.global_position
	var closest_enemy = null
	for e in ENMY:
		var d = get_dist_between_player(e)
		if d > 2 : continue
		if closest_enemy == null or d < get_dist_between_player(closest_enemy):
			closest_enemy = e
			continue
	if closest_enemy:
		_melee_to_Enemy(closest_enemy)

func _melee_to_Enemy(e):
	e.hit()
	if e.isDead():
		print('dead')
		ENMY.erase(e)
		e.queue_free()

