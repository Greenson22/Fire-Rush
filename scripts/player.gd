extends CharacterBody3D

@export var speed = 6.0
@export var jump_velocity = 10
var target_pos = Vector3(-1, -1, -5)
var next_position = Vector3.ZERO

@onready var navigation_agent:NavigationAgent3D = get_node('NavigationAgent3D')
@onready var cammot_ctr = CameraMouseController.new(self, null, Input.MOUSE_MODE_VISIBLE)
@onready var p_ctr = PlayerController.new(self, speed, jump_velocity)

func _input(event):
	cammot_ctr.toggle_mouse_capture()
	if event is InputEventMouseButton:
		if event.button_index == 1:
			navigation_agent.target_position = target_pos

func _process(_delta):
	next_position = navigation_agent.get_next_path_position()
	
func _physics_process(delta):
	var my_angle = -Vector2(global_position.x, global_position.z).angle_to_point(Vector2(next_position.x, next_position.z))
	rotation_degrees.y = rad_to_deg(my_angle)+90
	
	velocity = p_ctr.get_velocity_by_path(next_position)
	move_and_slide()
