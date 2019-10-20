extends Camera
"""
Camera user controlled that can be fixed for dialogs, events, ...
"""
signal shutter_visible
signal shutter_hidden

const TRANSPARENT = Color(1, 1, 1, 0)
const OPAQUE = Color(1, 1, 1, 1)
const RAY_LENGTH = 1000
const FLOOR_LAYER = 8

export (float) var speed_show_shutter = 0.5
export (float) var speed_hide_shutter = 0.2
export (float) var speed = 5.0


func _unhandled_input(event):
	if not Utils.get_game() or not Utils.get_game().user_has_control:
		return
	
	if event.is_action_pressed("ui_move"):
		var from = project_ray_origin(event.position)
		var to = project_ray_normal(event.position) * RAY_LENGTH
		var space_state = get_world().direct_space_state
		var collision = space_state.intersect_ray(from, to, [], FLOOR_LAYER)
		if collision:
			get_tree().call_group("player", "move_to", collision.position)


func _ready():
	$Shutter.modulate = Color(1, 1, 1, 0)


func show_shutter():
	"""
	Fade the shutter to display it
	"""
	$FadeTween.interpolate_property($Shutter, "modulate", 
		TRANSPARENT, OPAQUE, 
		speed_show_shutter, 
		Tween.TRANS_LINEAR, 0
	)
	$FadeTween.start()
	
	yield($FadeTween, "tween_all_completed")
	emit_signal("shutter_visible")


func hide_shutter():
	"""
	Fade the shutter to hide it
	"""
	$FadeTween.interpolate_property($Shutter, "modulate", 
		OPAQUE, TRANSPARENT, 
		speed_hide_shutter, 
		Tween.TRANS_LINEAR, 0
	)
	$FadeTween.start()
	
	yield($FadeTween, "tween_all_completed")
	emit_signal("shutter_hidden")


func _process(delta):
	if not Utils.get_game() or not Utils.get_game().user_has_control:
		return
	
	var direction = Vector3(0, 0, 0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_down"):
		direction.y -= 1
	if Input.is_action_pressed("ui_up"):
		direction.y += 1
	
	move(direction * delta)


func move(movement: Vector3):
	# Do not move on the fixed axis
	movement.z = 0.0
	
	global_transform.origin += movement * speed


func zoom_on(targets: Array):
	"""
	Compute bounding rect of given target and tries to give a clear view of all of them
	"""
	if targets.size() <= 0:
		return
	
	var first_character = targets.pop_front()
	var upper_left = first_character.get_global_transform().origin
	var lower_right = first_character.get_global_transform().origin
	
	for target in targets:
		var position = target.get_global_transform().origin
		if position.x < upper_left.x:
			upper_left.x = position.x
		if position.y < upper_left.y:
			upper_left.y = position.y
		
		if position.x > lower_right.x:
			lower_right.x = position.x
		if position.y > lower_right.y:
			lower_right.y = position.y
	
	set_position(upper_left + (lower_right - upper_left) / 2)


func set_position(position: Vector3):
	position.z = global_transform.origin.z
	global_transform.origin = position