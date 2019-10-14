extends Camera
"""
Camera user controlled that can be fixed for dialogs, events, ...
"""
signal shutter_visible
signal shutter_hidden

export (float) var speed = 5.0
var user_controlled = true


func _ready():
	$Shutter.modulate = Color(1, 1, 1, 0)


func fade_out():
	$FadeTween.interpolate_property($Shutter, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_LINEAR, 0)
	$FadeTween.start()
	
	yield($FadeTween, "tween_all_completed")
	print("shutter visible")
	emit_signal("shutter_visible")


func fade_in():
	$FadeTween.interpolate_property($Shutter, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_LINEAR, 0)
	$FadeTween.start()
	
	yield($FadeTween, "tween_all_completed")
	print("shutter hidden")
	emit_signal("shutter_hidden")


func _process(delta):
	if not Utils.get_game().user_has_control:
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
	
	if user_controlled:
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