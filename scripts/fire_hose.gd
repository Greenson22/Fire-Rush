@tool
extends Node3D

@export var active:bool = false
@export var spring_arm_path:NodePath

var spring_arm
@onready var particles:GPUParticles3D = get_node('GPUParticles3D')

var _pre_active

func _ready():
	spring_arm = get_node(spring_arm_path)

func _process(_delta):
	if active != _pre_active:
		particles.emitting = active
		_pre_active = active
	
	if not Engine.is_editor_hint():
		particles.rotation_degrees.z = -spring_arm.rotation_degrees.x-10
