extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		print(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
