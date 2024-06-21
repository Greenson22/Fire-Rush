extends CanvasLayer

@export var player_path:NodePath 

@onready var coordinate_label:Label = get_node('VBoxContainer/CoordinateLabel')
var player:CharacterBody3D

func _ready():
	player = get_node(player_path)

func _process(_delta):
	coordinate_label.text = str(floor(player.global_position))
