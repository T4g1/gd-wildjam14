extends Control


func _process(_delta):
	var position = get_parent().get_global_transform().origin
	var camera = Utils.get_camera()
	
	var screen_position = camera.unproject_position(position)
	rect_position = screen_position