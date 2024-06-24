class_name PlayerController

var speed = 0
var jump_velocity = 0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")+15
var velocity = Vector3.ZERO
var obj = null
var direction = Vector3.ZERO

func _init(_object=null, _speed=0, _jump_velocity=0):
	obj = _object
	speed = _speed
	jump_velocity = _jump_velocity

# menangani pergerakan
func movement(delta):
	jump()
	calculate_movement_direction()
	obj.velocity = get_velocity(delta)
	obj.move_and_slide()

func get_velocity_by_path(path):
	# mengarah ke target
	var _direction = obj.global_transform.origin.direction_to(path)
	# pergerakan
	velocity.x = _direction.x * speed
	velocity.z = _direction.z * speed
	return velocity

# ambil velocity
func get_velocity(delta):
	# Add the gravity.
	if not obj.is_on_floor():
		velocity.y -= gravity * delta
		
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		if obj.is_on_floor():
			velocity.x = lerp(velocity.x, 0.0, speed/100.0)
			velocity.z = lerp(velocity.z, 0.0, speed/100.0)
		else:
			velocity.x = lerp(velocity.x, 0.0, speed/500.0)
			velocity.z = lerp(velocity.z, 0.0, speed/500.0)
	return velocity

# Handle jump.
func jump():
	if Input.is_action_just_pressed("ui_accept") and obj.is_on_floor():
		velocity.y = jump_velocity

# ambil direction
func calculate_movement_direction():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	direction =  (obj.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
