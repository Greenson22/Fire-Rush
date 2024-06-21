class_name CameraMouseController

var mouse_sensitivity = 0.065
var mouse_rotate = Vector2.ZERO
var spring_arm3D:SpringArm3D = null
var mouse_rotation_value:Vector2 = Vector2(0, 0)
var center = null

func _init(obj=null, spring_arm=null, mouse_mode = Input.MOUSE_MODE_CAPTURED, ):
	Input.mouse_mode = mouse_mode
	spring_arm3D = spring_arm
	center = obj

# menggerakkan camera dengan mouse
func on_mouse_motion(event):
	if spring_arm3D and (event is InputEventMouseMotion) and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_rotation_value = Vector2(deg_to_rad(spring_arm3D.rotation_degrees.x), deg_to_rad(center.rotation_degrees.y))
		
		mouse_rotate.x = -event.relative.y*mouse_sensitivity
		mouse_rotate.y = -event.relative.x*mouse_sensitivity
		
		mouse_rotation_value.x += (mouse_rotate.x*mouse_sensitivity)
		mouse_rotation_value.y += (mouse_rotate.y*mouse_sensitivity)
		
		center.rotation_degrees.y = rad_to_deg(mouse_rotation_value.y)
		spring_arm3D.rotation_degrees.x = clamp(rad_to_deg(mouse_rotation_value.x), -70, 70)

func on_mouse_motion_next(event):
	toggle_mouse_capture()
	on_mouse_motion(event)

# menganti mouse mode dengan tombol esc
func toggle_mouse_capture():
	if Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
