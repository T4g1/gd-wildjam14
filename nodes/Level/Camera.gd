extends Camera

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		print("mouse", event.position)
		var from = project_ray_origin(event.position)
		var to = from + project_ray_normal(event.position) * 1000
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(from, to)
		get_tree().call_group("units", "move_to", Vector3(0, 0, 0))
		if result:
			print(result)
			get_tree().call_group("units", "move_to", result.position)