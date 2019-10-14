extends Camera
"""
Camera user controlled that can be fixed for dialogs, events, ...
"""

export (float) var speed = 5.0
var user_controlled = true


func _process(delta):
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
	
	#transform.origin += movement * speed


func zoom_on(targets: Array):
	"""
	Compute bounding rect of given target and tries to give a clear view of all of them
	"""
	if targets.size() <= 0:
		return
	
	var first_character = targets.pop_front()
	var upper_left = first_character.transform.origin
	var lower_right = first_character.transform.origin
	
	for target in targets:
		var position = target.transform.origin
		if position.x < upper_left.x:
			upper_left.x = position.x
		if position.y < upper_left.y:
			upper_left.y = position.y
		
		if position.x + 500 > lower_right.x:
			lower_right.x = position.x + 500
		if position.y > lower_right.y:
			lower_right.y = position.y

	#transform.origin = upper_left + (lower_right - upper_left) / 2