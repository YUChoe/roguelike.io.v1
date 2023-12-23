extends Camera3D

var PL;
var diff_pos;

func _ready():
	PL = get_parent().get_node("Player")		
	diff_pos = PL.position - position

func _process(delta):	
	position = PL.position - diff_pos

# TODO: spin 90'
