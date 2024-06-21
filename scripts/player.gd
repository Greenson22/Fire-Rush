extends CharacterBody3D

@export var speed = 6.0
@export var jump_velocity = 10
var target_pos = Vector3(-1, -1, -5)
var next_position = Vector3.ZERO

@onready var navigation_agent:NavigationAgent3D = get_node('NavigationAgent3D')
@onready var spring_arm3D:SpringArm3D = get_node("SpringArm3D")
@onready var fire_hose = get_node("FireHose")
@onready var cammot_ctr = CameraMouseController.new(self, spring_arm3D, Input.MOUSE_MODE_VISIBLE)
@onready var p_ctr = PlayerController.new(self, speed, jump_velocity)

func _input(event):
	cammot_ctr.toggle_mouse_capture()
	if event is InputEventMouseButton:
		if event.button_index == 1:
			navigation_agent.target_position = target_pos

func _process(_delta):
	next_position = navigation_agent.get_next_path_position()

func _physics_process(delta):
	velocity = p_ctr.get_velocity_by_path(next_position)
	move_and_slide()

func _on_timer_timeout():
	pass
