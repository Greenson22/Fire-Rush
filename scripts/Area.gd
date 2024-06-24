extends Area3D

@export var player_path:NodePath
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)

func _input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			player.target_pos = _position
			print("ditarget")
